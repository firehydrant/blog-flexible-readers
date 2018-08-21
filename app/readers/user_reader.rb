class UserReader
  include Enumerable
  include Pagy::Backend

  FILTERABLE_PARAMS = %i( role )

  def initialize(params = {})
    @params = params
  end

  def each(&block)
    paginate!
    @list.each(&block)
  end

  def pagination
    paginate!
    @pagination
  end

  private

  # Iterate through all of our filterable params
  # and append to the active record query as necessary
  def relation
    FILTERABLE_PARAMS.inject(User.all) do |relation, key|
      if params.has_key?(key) && params[key].present?
        send("filter_#{key}", relation, params[key])
      else
        relation
      end
    end
  end

  def filter_role(relation, role)
    relation.where(role: role)
  end

  # Check if our instance variables have been set and if not
  # run our query and paginate it.
  def paginate!
    return if defined?(@pagination) && defined?(@list)
    @pagination, @list = pagy(relation)
  end

  attr_reader :params
end
