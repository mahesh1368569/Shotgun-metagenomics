import argparse
from collections import defaultdict
from operator import itemgetter
import os

parser=argparse.ArgumentParser()

parser.add_argument('--unirefm8File', help = 'm8 file mapping the reads to Uniref')
parser.add_argument('--output_path', help = 'Path to the directory where the parsed output will be stored')

def main():
    args = parser.parse_args()
    m8file = args.unirefm8File
    outpath = args.output_path
    outfilename = outpath + "/" + os.path.basename(m8file) + "-parsed.txt"
    parseunirefm8(m8file, outfilename)

def parseunirefm8(filename, outf):
    d = defaultdict(list)
    ofh= open(outf,"w+")
    with open(filename) as f:
        for line in f:
            fields = line.split("\t")
            read = fields[0]
            UPid = fields[1]
            Evalue = fields[10]
            d[read].append((UPid,Evalue))
    for re in d:
        tup_list = d[re]
        top_UP_id = pick_top_hit(tup_list)
        lst_to_print=(re,top_UP_id)
        ofh.write('\t'.join(lst_to_print) + '\n')
    return d

def pick_top_hit(tupList):
    di = {}
    di = dict(tupList)
    mod_di = mutate_dict(lambda x: float(x), di)
    sorted_by_evalue = sorted(mod_di.items(), key = itemgetter(1))
    top_hit_tuple = sorted_by_evalue[0]
    top_hit_UP = top_hit_tuple[0]
    return top_hit_UP

def mutate_dict(f,d):
    new_d = {}
    for k, v in d.items():
        new_d[k] = f(v)
    return new_d

if __name__ == "__main__":
    main();
