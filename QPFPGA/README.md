```
cd /home/xilinx/QPFPGA

# compile cpp code in ZCU104 if any change is made or libqpfpga.so is missing
cd cpp
rm -rf build
mkdir build
cd build
cmake ..
make

cd /home/xilinx/QPFPGA

# run
sudo QPFPGA_LIBRARY="/home/xilinx/QPFPGA/cpp/build/libqpfpga.so" LD_LIBRARY_PATH="/usr/lib" /home/xilinx/qpfpga-venv/bin/python examples/cvxpy_qpfpga_demo.py

# run with CPU implementation
sudo QPFPGA_FORCE_CPU="yes" QPFPGA_LIBRARY="/home/xilinx/QPFPGA/cpp/build/libqpfpga.so" LD_LIBRARY_PATH="/usr/lib" /home/xilinx/qpfpga-venv/bin/python examples/cvxpy_qpfpga_demo.py
```