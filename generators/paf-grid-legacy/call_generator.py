from socket import send_fds
import subprocess



#3 5 7 9 11
#n 50  100 
#does it make send_fds
#7k 9 n?

# 6 *
# 5 20 75
# 3 20 75
# 7 20 75
# 4 *

# k = [2,3,4,5]
# n = [2,3,5, 10, 15, 20, 30, 50, 70]


k = [2,3,4,5,6,7]
n = [5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

for length in n:
    for width in k:
        i = 0
        for i in range(1,5): #generate 5 instances for each combination
            #call = "python praaf_grid_generator.py " + str(width) +" "+ str(length)+ " "+str(i)
            #process = subprocess.Popen([call], shell=True)
            #i+=1
            call = ["python3", "paf_grid_generator_stats.py", str(width), str(length), str(i)]
            process = subprocess.Popen(call)
            i += 1