# Thanks, ChatGPT
class JsonDiff
  def self.diff(old, new)
    differences = {}
    compare(old, new, nil, differences)
    differences
  end

  private

  def self.compare(old, new, path, differences)
    if old.is_a?(Hash) && new.is_a?(Hash)
      (old.keys | new.keys).each do |key|
        full_key = path ? "#{path}.#{key}" : key.to_s
        if old.key?(key) && new.key?(key)
          compare(old[key], new[key], full_key, differences)
        else
          differences[full_key] = [ old[key], new[key] ]
        end
      end
    elsif old.is_a?(Array) && new.is_a?(Array)
      [ old.length, new.length ].max.times do |i|
        full_key = path ? "#{path}[#{i}]" : "[#{i}]"
        compare(old[i], new[i], full_key, differences)
      end
    else
      differences[path] = [ old, new ] if old != new
    end
  end
end
