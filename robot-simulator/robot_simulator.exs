defmodule RobotSimulator do

  @directions [:north, :east, :south, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(dir \\ :north, pos \\ {0, 0})
  def create(dir, _pos) when not dir in @directions do
    {:error, "invalid direction"}
  end
  def create(_dir, pos) when not is_tuple(pos) do
    {:error, "invalid position"}
  end
  def create(_dir, pos) when tuple_size(pos) > 2 do
    {:error, "invalid position"}
  end
  def create(_dir, {x, y}) when not is_integer(x) or not is_integer(y) do
    {:error, "invalid position"}
  end
  def create(dir, {x, y}) do
    {x, y, dir}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    if (Regex.match?(~r/[^ARL]/, instructions)) do
      {:error, "invalid instruction"}
    else
      instructions = String.graphemes(instructions)
      Enum.reduce(instructions, robot, &execute/2)
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({_x, _y, dir}) do
    dir
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position({x, y, _dir}) do
    {x, y}
  end

  defp execute(step, robot) when step == "L" or step == "R" do
    turn(robot, step)
  end
  defp execute(step, robot = {x, y, dir}) when step == "A" do
    case dir do
      :north -> put_elem(robot, 1, y + 1)
      :east -> put_elem(robot, 0, x + 1)
      :south -> put_elem(robot, 1, y - 1)
      :west -> put_elem(robot, 0, x - 1)
    end
  end

  defp turn(robot, dir) when dir == "R" do
    case elem(robot, 2) do
      :north -> put_elem(robot, 2, :east)
      :east -> put_elem(robot, 2, :south)
      :south -> put_elem(robot, 2, :west)
      :west -> put_elem(robot, 2, :north)
    end
  end
  defp turn(robot, dir) when dir == "L" do
    case elem(robot, 2) do
      :north -> put_elem(robot, 2, :west)
      :west -> put_elem(robot, 2, :south)
      :south -> put_elem(robot, 2, :east)
      :east -> put_elem(robot, 2, :north)
    end
  end
end
