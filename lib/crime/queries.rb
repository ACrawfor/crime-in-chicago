module Crime
  QUERIES = {
    :ward_crime_hash => "
      select ward, count(*) crime_count
      from crimes
      where
        date_part('year', occurred_at) = :year and
        trim(ward) != ''
      group by ward
      order by ward::integer;".strip,
    :ward_crime_calendar => "
      select cast(occurred_at as date), count(*) as crime_count
      from crimes
      where ward = :ward and date_part('year', occurred_at) = :year
      group by cast(occurred_at as date)
      order by cast(occurred_at as date);".strip,
    :crime_max_daily_year => "
      select ward, occurred_at::date, count(*) max
      from crimes
      where date_part('year', occurred_at) = :year
      group by ward, occurred_at::date
      order by occurred_at::date desc
      limit 1".strip,
    :crime_ward_max_year => "
      select cast(occurred_at as date), count(*) as crime_count, ward
      from crimes
      where date_part('year', occurred_at) = :year
      group by cast(occurred_at as date), ward
      order by crime_count desc limit 1;".strip,
    :ward_crimes_per_year => "
      select cast(date_part('year',occurred_at) as int) as year, count(*) as crime_count_for_year
      from crimes 
      where ward = :ward and date_part('year',occurred_at) > 2001
      group by date_part('year', occurred_at) 
      order by year;".strip
  }
end