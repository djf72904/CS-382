lineMarker = ['00', '10', '20', '30', '40', '50', '60', '70', '80', '90', 'a0', 'b0', 'c0', 'd0', 'e0', 'f0']

opCodes = {
    'STR': '00',
    'LDR': '01',
    'ADD': '10',
    'SUB': '11'
}

regCodes = {
    'r0': '00',
    'r1': '01',
    'r2': '10',
    'r3': '11'
}


# adds contents to file by splitting up list into smaller sub arrays to create a matrix
# goes through matrix and at each subarray, write to the file
def addToInstructionsFile(file, matrix):
    splitInterval = 16
    matrixLength = len(matrix)
    rng = range(0, matrixLength, splitInterval)
    # this splits the matrix every 16 elements
    matrix = [matrix[i:i + splitInterval] for i in rng]

    for i in range(len(matrix)):
        file.write(lineMarker[i] + ": " + " ".join(matrix[i]))
        if i != len(matrix) - 1:
            file.write('\n')


def addToDataFile(data):

    file = open('data.txt', 'w')
    file.write("v3.0 hex words addressed \n")
    hexContents = []
    for i in range(len(data)):
        hexContents.append(hex(int(data[i]['value'])).split("x")[1])

    splitInterval = 16
    matrixLength = len(hexContents)
    rng = range(0, matrixLength, splitInterval)
    matrix = [hexContents[i:i + splitInterval] for i in rng]

    for i in range(len(matrix)):
        file.write(lineMarker[i] + ": " + " ".join(matrix[i]))
        if i != len(matrix) - 1:
            file.write('\n')


def parseDataSection(lineNumber):
    dataContents = []

    dataFile = open('asm.txt', 'r')

    for j in range(lineNumber):
        dataFile.readline()
    data = dataFile.readlines()

    for j in data:
        data = j.replace('\n', '').split(" ")
        while "" in data:
            data.remove("")

        try:
            lineContent = {
                'type': data[0],
                'value': data[1]
            }

            dataContents.append(lineContent)
        except:
            continue

    isValid = False

    for j in dataContents:
        if (j['type'] != '.byte'):
            print("'{}' not permitted. Please use '.byte'".format(j['type']))
            isValid = False
            break
        else:
            isValid = True
    if isValid:
        addToDataFile(dataContents)




def main():
    # opens the file with reading permissions
    file = open("asm.txt", "r")
    fileContents = file.readlines()
    hexContents = []

    lineNumber = 1

    # goes through each line in the assembly file
    for i in fileContents:
        if i.replace(" ", '').find("//") == 0:
            print("The usage of comments must be used on the same line as code.")
            break
        line = i.replace("\n", "").split(" ")
        if line == [''] or line == ['.text:'] or line == ['.data:']:  # checks for blank line
            if line == ['.data:']:
                # data field must be at bottom of file
                parseDataSection(lineNumber)
                break
            else:
                lineNumber += 1
                pass
        else:
            # removes tabs before the text in each line
            while "" in line:
                line.remove("")
            instruction = line[0]
            op = opCodes.get(instruction)
            try:
                binaryCode = (op + regCodes.get(line[1]) + regCodes.get(line[2]) + regCodes.get(line[3]))
            except:
                print("The usage of registers greater than r3 is not permitted.")
                break
            hexContents.append(str(hex(int(binaryCode, 2))).split("x")[1])
            lineNumber += 1
    # opens the file with writing permissions

    file.close()
    file = open('text.txt', 'w')

    file.write("v3.0 hex words addressed \n")

    # calls the addToFile with
    addToInstructionsFile(file, hexContents)
    file.close()


if __name__ == '__main__':
    main()
