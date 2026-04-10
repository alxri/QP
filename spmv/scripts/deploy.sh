#!/bin/bash

# Absolute base directory for the project
BASE_DIR="/home/romoirib/QP/spmv"

TARGET_IP="192.168.2.99"
TARGET_USER="xilinx"
TARGET_DIR="/home/xilinx/spmv_csr"

echo "Creating target directory on PYNQ board..."
sshpass -p "xilinx" ssh $TARGET_USER@$TARGET_IP "mkdir -p $TARGET_DIR"

echo "Transferring spmv.bit..."
sshpass -p "xilinx" scp ${BASE_DIR}/spmv.bit $TARGET_USER@$TARGET_IP:$TARGET_DIR/

echo "Transferring spmv.hwh..."
sshpass -p "xilinx" scp ${BASE_DIR}/spmv.hwh $TARGET_USER@$TARGET_IP:$TARGET_DIR/

echo "Deployment complete! Files are available in $TARGET_DIR on the board."
