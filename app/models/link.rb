class Link < ActiveRecord::Base
  
  has_many :visits
  
  validates_presence_of :long_url, :on => :create, :message => "can't be blank"
  validates_presence_of :domain_id, :on => :create, :message => "can't be blank"
  validates_format_of :long_url, :with => /^(http|https):\/\/[a-z0-9]/ix, :on => :create, :message => "must begin with http:// or https://"

  before_create :generate_token

  def add_visit(request)
    visit = visits.build(:ip_address => request.remote_ip, :browser => request.env['HTTP_USER_AGENT'])
    visit.save
    return visit
  end
  
  def generate_token
    if (temp_token = random_token) and self.class.find_by_token_and_domain_id(temp_token, domain_id).nil?
      self.token = temp_token
      build_permalink
    else
      generate_token
    end
  end
  
  def build_permalink
    self.short_url = "http://" + Domain.find(domain_id).name + "/" + self.token
  end

  def random_token
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'
    temp_token = ''
    srand
    TOKEN_LENGTH.times do
      pos = rand(characters.length)
      temp_token += characters[pos..pos]
    end
    temp_token
  end


end
