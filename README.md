# RISC-V Framework

## Instructions

Clone using:

```shell
git clone https://github.com/binhkieudo/NewFramework.git
cd NewFramework
git checkout dev
```

## Install conda enviroment

Download and install Anaconda first

```shell
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
sudo chmod a+x ./Anaconda3-2023.09-0-Linux-x86_64.sh
./Anaconda3-2023.09-0-Linux-x86_64.sh
```

Then install conda-lock for "base" environment

```shell
conda install -n base conda-lock=1.4
```

## Build chipyard enviroment

Active coda first

```shell
conda activate
```
Then build the related tools

```shell
echo y | ./build-setup.sh -s 9 -s 8 riscv-tools
```

## Active chipyard environment

You have to active the chipyard environment whenever working with chipyard framework.

```shell
source env.sh
```

## Prepare SD-card 
You'll need the gptfdisk tool to format the SD card

Download and install gptfdisk
```shell
git clone https://github.com/tmagik/gptfdisk.git
cd gptfdisk
make -j`nproc`
```

Connect the SD-card to your PC, then:
```shell
cd gptfdisk/
sudo ./gdisk /dev/sd?
```
Where ? points to the SD card.

After opening the SD card, check the existing partitions by pressing p, then Enter.
<img src="https://github.com/binhkieudo/riscv_framework/assets/22954544/9ce04d3a-1c11-4ff5-b44c-31357dc6454c" alt="drawing" width="700"/>

Delete all existing partitions by command d with the corresponding partition's number. 
<img src="https://github.com/binhkieudo/riscv_framework/assets/22954544/442702fc-610e-44b7-bcbb-5c5b13bf88fe" alt="drawing" width="600"/>

Then format the SD Card with the following options:
<img src="https://github.com/binhkieudo/riscv_framework/assets/22954544/2931ed12-4bef-4e6e-96b7-551d8059d15a" alt="drawing" width="700"/>

After formatting the SD Card, print the new partition and save the configurations.
<img src="https://github.com/binhkieudo/riscv_framework/assets/22954544/a657a6da-617b-409a-8b2f-4f7ec7f96128" alt="drawing" width="700"/>

## Prepare your first DEMO with FPGA (currently support D2-115)

Quartus must be in your PATH

Enter Demo FPGA folder
```shell
cd ./Demo/FPGA
```
