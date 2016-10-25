require 'data_mapper'
DataMapper::Logger.new($stdout, :info)
# path = File.dirname(File.absolute_path(__FILE__) )
# root_path = Pathname.new(path).parent
# DataMapper.setup(:default, "sqlite://#{root_path.to_s}/dev.db")
username = CredService.creds.postgres.username
password = CredService.creds.postgres.password
host     = CredService.creds.postgres.host
database = CredService.creds.postgres.database
DataMapper.setup(:default, "postgres://#{username}:#{password}@#{host}/#{database}")
path = File.dirname( File.absolute_path(__FILE__) )
Dir.glob(path + '/db/*').delete_if{ |file| File.directory?(file) || Pathname.new(file).extname != '.rb' || file == __FILE__ }.each{ |file| require file }
DataMapper.finalize
DataMapper.auto_upgrade!

#monkeypatch
class DataMapper::Collection
  def batch(n)
    Enumerator.new do |y|
      offset = 0
      loop do
        records = slice(offset, n)
        break if records.empty?
        records.each { |record| y.yield(record) }
        offset += records.size
      end
    end
  end
end
