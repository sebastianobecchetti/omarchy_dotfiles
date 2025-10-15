#!/bin/bash

# Sincronizza la cartella OneDrive, escludendo Immagini
rclone bisync  onedrive: ~/onedrive --exclude "Immagini/**"

