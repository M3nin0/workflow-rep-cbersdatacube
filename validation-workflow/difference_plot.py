#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import click
import seaborn as sns
import rasterio as rio
import matplotlib.pyplot as plt

from sklearn.metrics import confusion_matrix


@click.command()
@click.option('--map1', required=True, help='LULC Map gerado na primeira execução')
@click.option('--map2', required=True, help='LULC Map gerado na segunda execução')
@click.option('--typeof', required=True, help='Tipo da produção (Replicação ou reuso)')
def difference_plot_cli(map1, map2, typeof):
    ds_1 = rio.open(map1)
    ds_2 = rio.open(map2)

    #
    # create basepath
    #
    basepath = os.path.join('validation-workflow/results/', typeof,)
    os.makedirs(basepath, exist_ok=True)

    #
    # load =D
    #
    arr_1 = ds_1.read().ravel()
    arr_2 = ds_2.read().ravel()

    #
    # Confusion Matrix
    #
    plt.figure(dpi = 300)

    cf_matrix = confusion_matrix(arr_1, arr_2)
    sns.heatmap(cf_matrix, 
                annot=True, 
                cbar=False, 
                linecolor='black',
                linewidths=.3,
                cmap='gist_yarg')

    plt.xlabel("Classes geradas (Execução 1)")
    plt.ylabel("Classes geradas (Execução 2)")

    plt.savefig(os.path.join(basepath, 'cf.png'), dpi=600, bbox_inches='tight', pad_inches=0.0)

if __name__ == '__main__':
    difference_plot_cli()
