import regex

texts = ['/home/comar/tmp.cmp',
        './dkdk/foo.jpg',
        'foo.jpg',
        'foo.kk.jpg',
        ]


for text in texts:

    directory = 'unknown'
    file = 'unknown'
    directory = regex.findall(r'[^/]+(?<=\.)',text)[0]
    file = regex.findall(r'[^/]+', text)[-1]
    print('------------------')
    print('original : %s'%text)
    print('file     : %s'%file)
    print('dir      : %s'%directory)


