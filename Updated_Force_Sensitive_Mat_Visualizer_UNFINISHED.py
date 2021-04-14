# UNFINISHED BY EDDY KIM (NOT REALLY WORKING)
# MAKE SURE TO INSTALL PYFIRMATA, MATPLOTLIB AND SEABORN
# IF THIS CODE IS TO BE USED FOR THE UPSCALED FORCE MAT, ENSURE TO UPDATE IT TO 128*64

import pyfirmata
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

board = pyfirmata.Arduino('COM3', baudrate=57600)

for i in range(10,7,-1):
    board.digital[i].write(0)

for j in range(13, 10,-1):
    board.digital[i].write(1)

zOutput = board.get_pin('d:5:p')
zOutput.write(1)

zInput = board.get_pin('a:0:i')

force = [ [0] * 8 for i in range(8)]

print(zInput.read())

#force = sns.load_dataset(matrix)
#force = force.pivot("", "Seconds set of wires", "Force Mat Prototype")

# ax = sns.heatmap(force, vmin = 0, vmax = 1, cmap="YlGnBu", linewidths=.5, xticklabels = False, yticklabels = False)
# ax.set(title="Force Mat Prototype",
#       xlabel="Second Set of Wires",
#       ylabel="",)
#plt.show()

while (True):
    for row in range(0, 8):
        for i in range(0, 3):
            if (row & 1 << i):
                board.digital[10 - i].write(1)
            else:
                board.digital[10 - i].write(0)
        
        for column in range(0, 8):
            for j in range(0,3):
                if (column & 1 << j):
                    board.digital[13 - i].write(1)
                else:
                    board.digital[13 - i].write(0)
            
                force[7 - row][column] = zInput.read()
                
                # ax = sns.heatmap(force, vmin = 0, vmax = 1, cmap="YlGnBu", linewidths=.5, xticklabels = False, yticklabels = False)
                # ax.set(title="Force Mat Prototype",
                #     xlabel="Second Set of Wires",
                #     ylabel="",)

    for x in range(8):
        for y in range(8):
            print("%d" % (force[7 - x][y]))
        print("\n")
    print("\n\n")
                # plt.draw()
