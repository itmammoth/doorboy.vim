runtime! plugin/doorboy.vim

source spec_helper.vim

describe 'quotations'
  after
    normal ggdG
  end

  context 'when no characters in the current line'
    " double quotation "
    context 'and putting "#'
      it 'should put " twice'
        call spec_helper#insert_chars('"#')
        Expect getline(1) == '"#"'
      end
    end

    context 'and putting ""#'
      it 'should put " twice and skip'
        call spec_helper#insert_chars('""#')
        Expect getline(1) == '""#'
      end
    end

    " single quotation '
    context "and putting '#"
      it "should put ' twice"
        call spec_helper#insert_chars("'#")
        Expect getline(1) == "'#'"
      end
    end

    context "and putting ''#"
      it "should put ' twice and skip'"
        call spec_helper#insert_chars("''#")
        Expect getline(1) == "''#"
      end
    end

    " back quotation `
    context "and putting `#"
      it "should put ` twice"
        call spec_helper#insert_chars("`#")
        Expect getline(1) == "`#`"
      end
    end

    context "and putting ``#"
      it "should put ` twice and skip"
        call spec_helper#insert_chars("``#")
        Expect getline(1) == "``#"
      end
    end
  end

  context 'when cursor is between quotations'
    before
      call spec_helper#put_with_cursor('"|"')
    end

    context 'and pressing backspace'
      it 'should delete both quotations'
        call spec_helper#insert_bs()
        Expect getline(1) == ''
      end
    end

    context 'and pressing the same quotation as written'
      it 'should skip the quotation'
        call spec_helper#insert_chars('"#')
        Expect getline(1) == '""#'
      end
    end
  end

  context 'when cursor is left of word'
    before
      call spec_helper#put_with_cursor('|word')
    end

    context 'and pressing "'
      it 'should put " once'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"word'
      end
    end
  end

  context 'when cursor is left of )'
    before
      call spec_helper#put_with_cursor('|)')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"")'
      end
    end
  end

  context 'when cursor is left of }'
    before
      call spec_helper#put_with_cursor('|}')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '""}'
      end
    end
  end

  context 'when cursor is left of ]'
    before
      call spec_helper#put_with_cursor('|]')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '""]'
      end
    end
  end

  context 'when cursor is left of >'
    before
      call spec_helper#put_with_cursor('|>')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"">'
      end
    end
  end

  context 'when cursor is left of ,'
    before
      call spec_helper#put_with_cursor('|,')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"",'
      end
    end
  end

  context 'when cursor is left of .'
    before
      call spec_helper#put_with_cursor('|.')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"".'
      end
    end
  end

  context 'when cursor is left of ='
    before
      call spec_helper#put_with_cursor('|=')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '""='
      end
    end
  end

  context 'when cursor is left of space'
    before
      call spec_helper#put_with_cursor('| ')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"" '
      end
    end
  end

  context 'when cursor is left of Japanese'
    before
      call spec_helper#put_with_cursor('|独自')
    end

    context 'and pressing "'
      it 'should put " once'
        call spec_helper#insert_chars('"')
        Expect getline(1) == '"独自'
      end
    end
  end

  context 'when cursor is right of word'
    before
      call spec_helper#put_with_cursor('word|')
    end

    context 'and pressing "'
      it 'should put " once'
        call spec_helper#append_chars('"')
        Expect getline(1) == 'word"'
      end
    end
  end

  context 'when cursor is right of ('
    before
      call spec_helper#put_with_cursor('(|')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == '(""'
      end
    end
  end

  context 'when cursor is right of {'
    before
      call spec_helper#put_with_cursor('{|')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == '{""'
      end
    end
  end

  context 'when cursor is right of ['
    before
      call spec_helper#put_with_cursor('[|')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == '[""'
      end
    end
  end

  context 'when cursor is right of >'
    before
      call spec_helper#put_with_cursor('>|')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == '>""'
      end
    end
  end

  context 'when cursor is right of ,'
    before
      call spec_helper#put_with_cursor(',|')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == ',""'
      end
    end
  end

  context 'when cursor is right of .'
    before
      call spec_helper#put_with_cursor('.|')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == '.""'
      end
    end
  end

  context 'when cursor is right of ='
    before
      call spec_helper#put_with_cursor('=|')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == '=""'
      end
    end
  end

  context 'when cursor is right of space'
    before
      call spec_helper#put_with_cursor(' |')
    end

    context 'and pressing "'
      it 'should put " twice'
        call spec_helper#append_chars('"')
        Expect getline(1) == ' ""'
      end
    end
  end
end
