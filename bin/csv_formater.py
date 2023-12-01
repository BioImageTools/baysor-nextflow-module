import pandas as pd 
import os 
import fire

def csv2baysor(
    csv_path: str,
    outdir: str = '.'
):
    df = pd.read_csv(csv_path)
    df = df[df['decoded_spots']]
    df = df[['xc', 'yc', 'target_postcode']]
    df.to_csv(os.path.join(outdir, 'spots_filt.csv'), index=False)

if __name__ == '__main__':
    cli = {
        "run": csv2baysor
    }
    fire.Fire(cli)