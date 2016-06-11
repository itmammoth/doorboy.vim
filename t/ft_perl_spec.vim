runtime! plugin/doorboy.vim

source spec_helper.vim

set filetype=perl

describe 'ftplugin/perl'
  after
    normal ggdG
  end

  context 'when no characters in the current line'
    context 'and putting /'
      it 'should put / twice'
        call spec_helper#insert_chars('/perl')
        Expect getline(1) == '/perl/'
      end
    end
  end
end
