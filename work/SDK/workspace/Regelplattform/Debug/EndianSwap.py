file = open("flash.srec", 'r')
newFile = open("flash_le.srec", 'w')

for line in file:
	charList = []
	newList = []
	
	for char in line:
		charList.append(char)

	for i in range(0, len(charList) - 1, 2):
		newList.append(charList[i + 1])
		newList.append(charList[i])
	#print newList
	
	for j in range(0, len(newList), 1):
		char = newList[j]
	#	print char.encode("hex")
		newFile.write(char)
		newFile.flush()
		
file.close()
newFile.close()