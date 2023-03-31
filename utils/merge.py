import sys
import os
import glob
import pandas as pd

def combine_parquet_files(filepaths, target_path):
    if not os.path.exists(os.path.dirname(target_path)):
        os.mkdir(os.path.dirname(target_path))
    try:
        files = []
        for file_name in filepaths:
            files.append(pd.read_parquet(file_name))

        merged = pd.concat(files)
        merged.to_parquet(target_path)
    except Exception as e:
        print(e)

if len(sys.argv)>=2:
    BASE_DIR = sys.argv[1]
else:
    BASE_DIR="/hdd/iaross/cosmos_6Aug_reload_output/"

for parq in [
"documents_5Feb_equations.parquet",
"documents_5Feb_figures.parquet",
"documents_5Feb_sections.parquet",
"documents_5Feb.parquet",
"documents_5Feb_pdfs.parquet",
"documents_5Feb_tables.parquet",
]:
    file_paths = glob.glob(os.path.join(BASE_DIR, "x[a-z][a-z]*", parq))
    import pdb; pdb.set_trace()
    print(f"Merging {file_paths}")
    combine_parquet_files(file_paths, os.path.join(BASE_DIR, "merged", parq))

## for some reason doc_sections and doc_figures are getting written out differently...
#
#for parq in [
#"documents_sections.parquet"]:
#    file_paths = glob.glob(f"../run[ACGHIJK]/output/{parq}")
#    combine_parquet_files(file_paths, parq + ".part1")
#
#    file_paths = glob.glob(f"../run[BDEF]/output/{parq}")
#    combine_parquet_files(file_paths, parq + ".part2")
#
#for parq in [
#"documents_figures.parquet"]:
#    file_paths = glob.glob(f"../run[ACEFHIJ]/output/{parq}")
#    combine_parquet_files(file_paths, parq + ".part1")
#
#    file_paths = glob.glob(f"../run[BDGK]/output/{parq}")
#    combine_parquet_files(file_paths, parq + ".part2")
#
