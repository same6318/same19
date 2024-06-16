require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "バリデーション" do
    it "タイトルが未入力の場合、タスクのバリデーションが無効であること" do
      #テストコードの処理
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid #task.valid?の結果がfalseになることを、be_invalidで確認
      #expect(task.valid?).to be falseと同じ。
      #タスクの値は有効か？という質問に対して、falseが返ることを確認している。
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end
  
    it "ステータスが未入力の場合、タスクのバリデーションが無効であること" do
      #テストコードの処理
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "完了期限が未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: nil)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
    end

    it "完了期限が過去の日付の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.zone.yesterday)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline must start from today."]
    end

    it "完了期限が今日の日付の場合、タスクのバリデーションが有効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_valid
      #expect(task.errors.full_messages).to eq ["Deadline must start from today."] 
    end

  end
  
end