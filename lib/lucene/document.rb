module Lucene
  class Document
    
    attr_reader :id_field, :field_infos  
    
    def initialize(field_infos, props = {})
      @id_field = field_infos.id_field
      @field_infos = field_infos

      @props = {}
      props.each_pair do |key,value|
        @props[key] = field_infos[key].convert_type(value)
        puts "Converted #{key} '#{value}' type: '#{value.class.to_s}' to '#{@props[key].class.to_s}'"
      end
    end

    def [](key)
      @props[key]
    end
    
    #
    # Convert a java Document to a ruby Lucene::Document
    #
    def self.convert(field_infos, java_doc)
      fields = {}
      field_infos.each_pair do |key, field|
        #puts "Convert field #{key} store=#{field.store?}"
        next unless field.store?
        #value = yield key.to_s
        value = java_doc.getField(key.to_s).stringValue
        fields.merge!({key => value})
      end
      Document.new(field_infos, fields)
    end

    def id
      raise IdFieldMissingException.new("Missing id field: '#{@id_field}'") if self[@id_field].nil?
      @props[@id_field]      
    end

    def eql?(other)
      return false unless other.is_a? Document
      return id == other.id
    end

    def ==(other)
      eql?(other)
    end
    
    def hash
      id.hash
    end
    
    #
    # removes the document and adds it again
    #
    def update(index_writer)
      index_writer.updateDocument(java_key_term, java_document)
    end
    
    
    def java_key_term
      org.apache.lucene.index.Term.new(@id_field.to_s, id.to_s)
    end
    
    def java_document
      java_doc   =   org.apache.lucene.document.Document.new
      @props.each_pair do |key,value|
        field_info = @field_infos[key]
        # TODO value could be an array if value.kind_of? Enumerable
        field = field_info.java_field(key,value)
        java_doc.add(field)
      end
      java_doc
    end
    
    def to_s
      "Document [#@id_field='#{self[@id_field]}', #{@props.size} fields]"
    end
  end
end