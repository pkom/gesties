# -*- encoding: utf-8 -*-
import zipfile, os, os.path
from tempfile import mkdtemp


def descomprime(filezip):
    if filezip[-4:].lower() == ".zip":
        temp = mkdtemp()
        zfobj = zipfile.ZipFile(filezip, 'r')
        for name in zfobj.namelist():
            if name.endswith('/'):
                try: # Don't try to create a directory if exists
                    os.mkdir(os.path.join(temp, name))
                except:
                    pass
            else:
                outfile = open(os.path.join(temp, name), 'wb')
                outfile.write(zfobj.read(name))
                outfile.close()
        return temp
