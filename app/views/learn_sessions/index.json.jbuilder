json.array!(@learn_sessions) do |learn_session|
  json.extract! learn_session, :id
  json.url learn_session_url(learn_session, format: :json)
end
