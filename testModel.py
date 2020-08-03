import matlab.engine

print("starting engine...")
eng = matlab.engine.start_matlab()
print("finish engine starting")

tf = eng.ReadEK80RawFile('Fishing38-D20160605-T064313.raw')
# print(tf)
