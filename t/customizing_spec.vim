runtime! plugin/doorboy.vim

source spec_helper.vim

set filetype=vspec

describe 'customizing'
  after
    normal ggdG
  end

  describe 'doorboy#add_quotation'
    before
      call doorboy#add_quotations('vspec', ['|'])
    end

    it 'should add custom quotation properly'
      call spec_helper#insert_chars('do |x')
      Expect getline(1) == 'do |x|'
    end
  end

  describe 'doorboy#disable_quotation'
    before
      call doorboy#disable_quotation('"')
    end

    it 'should disable specified quotation'
      call spec_helper#insert_chars('"')
      Expect getline(1) == '"'
    end
  end
end
