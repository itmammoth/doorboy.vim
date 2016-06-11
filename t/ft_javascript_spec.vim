runtime! plugin/doorboy.vim

source spec_helper.vim

set filetype=javascript

describe 'ftplugin/javascript'
  after
    normal ggdG
  end

  context 'when no characters in the current line'
    context 'and putting /'
      it 'should put / twice'
        call spec_helper#insert_chars('/javascript')
        Expect getline(1) == '/javascript/'
      end
    end
  end
end
