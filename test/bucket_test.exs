defmodule BucketTest do
  use ExUnit.Case

  setup do
    {:ok, bucket} = Bucket.start_link([])

    %{bucket: bucket}
  end

  test "should store values by key", %{bucket: bucket} do
    Bucket.put(bucket, "smetan", 3)

    assert Bucket.get(bucket, "smetan") == 3
  end

  test "should respond with nil for an invalid key",
       %{bucket: bucket} do
    assert Bucket.get(bucket, "pnduk") == nil
  end

  test "should properly update the key", %{bucket: bucket} do
    Bucket.put(bucket, "smetan", 3)

    assert Bucket.get(bucket, "smetan") == 3

    Bucket.put(bucket, "smetan", 5)

    assert Bucket.get(bucket, "smetan") == 5
  end

  test "should remove a key completely", %{bucket: bucket} do
    Bucket.put(bucket, "smetan", 3)

    Bucket.remove_all(bucket, "smetan")

    assert Bucket.get(bucket, "smetan") == nil
  end

  test "should be able to remove a key partially",
       %{bucket: bucket} do
    Bucket.put(bucket, "smetan", 3)

    Bucket.remove(bucket, "smetan", 2)

    assert Bucket.get(bucket, "smetan") == 1
  end

  test "should nullify the slot, if removing more than available",
       %{bucket: bucket} do
    Bucket.put(bucket, "smetan", 3)

    Bucket.remove(bucket, "smetan", 5)

    assert Bucket.get(bucket, "smetan") == nil
  end
end
