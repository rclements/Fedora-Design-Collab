# This module adds support for finding the object in a voteable collection
# with the highest vote score, rather than just the highest number of votes
# (I'm looking at you, tally)
module VoteFuHighestExtension
  # Calculate the vote counts for all voteables of my type.
  def highest_tally(options = {})
    find(:all, options_for_highest_tally(options.merge({:order =>"vote DESC" })))
  end

  #
  # Options:
  #  :start_at    - Restrict the votes to those created after a certain time
  #  :end_at      - Restrict the votes to those created before a certain time
  #  :conditions  - A piece of SQL conditions to add to the query
  #  :limit       - The maximum number of voteables to return
  #  :order       - A piece of SQL to order by. Eg 'votes.count desc' or 'voteable.created_at desc'
  #  :at_least    - Item must have at least X votes
  #  :at_most     - Item may not have more than X votes
  def options_for_highest_tally (options = {})
      options.assert_valid_keys :start_at, :end_at, :conditions, :at_least, :at_most, :order, :limit

      scope = scope(:find)
      start_at = sanitize_sql(["#{Vote.table_name}.created_at >= ?", options.delete(:start_at)]) if options[:start_at]
      end_at = sanitize_sql(["#{Vote.table_name}.created_at <= ?", options.delete(:end_at)]) if options[:end_at]

      type_and_context = "#{Vote.table_name}.voteable_type = #{quote_value(base_class.name)}"

      conditions = [
        type_and_context,
        options[:conditions],
        start_at,
        end_at
      ]

      conditions = conditions.compact.join(' AND ')
      conditions = merge_conditions(conditions, scope[:conditions]) if scope

      joins = ["LEFT OUTER JOIN #{Vote.table_name} ON #{table_name}.#{primary_key} = #{Vote.table_name}.voteable_id"]
      joins << scope[:joins] if scope && scope[:joins]
      at_least  = sanitize_sql(["COUNT(#{Vote.table_name}.id) >= ?", options.delete(:at_least)]) if options[:at_least]
      at_most   = sanitize_sql(["COUNT(#{Vote.table_name}.id) <= ?", options.delete(:at_most)]) if options[:at_most]
      having    = [at_least, at_most].compact.join(' AND ')
      group_by  = "#{Vote.table_name}.voteable_id HAVING COUNT(#{Vote.table_name}.id) > 0"
      group_by << " AND #{having}" unless having.blank?

      { :select     => "#{table_name}.*, SUM(#{Vote.table_name}.vote) AS vote",
        :joins      => joins.join(" "),
        :conditions => conditions,
        :group      => group_by
      }.update(options)
  end
end
