# 

import codecs

from lxml import etree

def main():
    
    filename = '01sample_internal.xml'

    f = open(filename,"rb")

    in_encoded = 'GBK'

    out_encoded = 'utf-8'

    f = codecs.EncodedFile(f,out_encoded,in_encoded)

    xslt = '04map_MATMAS05_FlexNet_Products.xslt'

    #xslt = 'MapToFlexNet_Products.xslt'
     
    xslt_root = etree.parse(xslt)
     
    #fn = "01sample_internal2.xml"
     
    doc = etree.parse(f)

    transform = etree.XSLT(xslt_root)

    result_tree = transform(doc)

    if xslt == 'MapToFlexNet_Products.xslt':    
        fo = "output03.xml"
    else:
        fo = "output04.xml"

    fh  = open(fo, 'wb')

    xml_string = result_tree

    fh.write(xml_string)

    fh.close()

if __name__ == "__main__":
    main()

 