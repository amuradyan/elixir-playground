defmodule Bucket do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  def remove_all(bucket, key) do
    Agent.update(bucket, &Map.put(&1, key, nil))
  end

  def remove(bucket, key, quantity) do
    curr = Agent.get(bucket, &Map.get(&1, key))

    diff = curr - quantity

    if diff < 0 do
      Agent.update(bucket, &Map.put(&1, key, nil))
    else
      Agent.update(bucket, &Map.put(&1, key, diff))
    end
  end
end
