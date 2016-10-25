runtime! plugin/doorboy.vim
setlocal runtimepath+=./vim-slim

source spec_helper.vim

set filetype=slim

describe 'ftplugin/slim'
  after
    normal ggdG
  end

  context 'when cursor is not in ruby syntax'
    context 'and putting |'
      it 'should put | once'
        call spec_helper#insert_chars('|')
        Expect getline(1) == '|'
      end
    end
    context 'and putting /'
      it 'should put / once'
        call spec_helper#insert_chars('/')
        Expect getline(1) == '/'
      end
    end
    context 'and putting #'
      it 'should put #'
        call spec_helper#insert_chars('#')
        Expect getline(1) == '#'
      end
    end
  end

  context 'when cursor is in ruby syntax'
    context 'and putting |'
      before
        call spec_helper#put_with_cursor('- @items.each do |')
      end
      it 'should put | twice'
        call spec_helper#append_chars('|item')
        Expect getline(1) == '- @items.each do |item|'
      end
    end
    context 'and putting /'
      before
        call spec_helper#put_with_cursor('- str =~ |')
      end
      it 'should put / twice'
        call spec_helper#append_chars('/pattern')
        Expect getline(1) == '- str =~ /pattern/'
      end
    end
    context 'and putting # in string literals'
      before
        call spec_helper#put_with_cursor('p = "|"')
      end
      it 'should put #{}<LEFT>'
        call spec_helper#insert_chars('#value')
        Expect getline(1) == 'p = "#{value}"'
      end
    end
  end
end
