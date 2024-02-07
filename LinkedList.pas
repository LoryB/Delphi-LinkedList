{*****************************************************************}
{                                                                 }
{          Generic Linked List implementation for Delphi          }
{                Inspired by C# TLinkedList class                 } 
{                                                                 }
{               Copyright (c) 2024 by Lorenzo Bardi               }
{                                                                 }
{      This source code is distributed under the Library GNU      }
{     General Public License with the following modification:     }
{     - object files and libraries linked into an application     }
{              may be distributed without source code.            }
{                                                                 }
{ This program is distributed in the hope that it will be useful, } 
{ but WITHOUT ANY WARRANTY; without even the implied warranty of  }
{     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.        }
{                                                                 }
{*****************************************************************}

unit LinkedList;

interface

uses
  System.SysUtils;

type
  TNode<T> = class
  public
    Value: T;
    Next: TNode<T>;
    constructor Create(AValue: T);
  end;

  TLinkedList<T> = class
  private
    FHead: TNode<T>;
    FTail: TNode<T>;
    FCount: Integer;
    function GetFirstNode: TNode<T>;
    function GetLastNode: TNode<T>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddFirst(Value: T);
    procedure AddLast(Value: T);
    function RemoveFirst: T;
    function RemoveLast: T;
    function Remove(const Value: T): Boolean;
    procedure Clear;
    function Contains(const Value: T): Boolean;
    procedure CopyTo(var ArrayOfT: array of T; Index: Integer);
    function ElementAt(Index: Integer): T;
    function First: T;
    function Last: T;
    function IndexOf(const Value: T): Integer;
    function RemoveAt(Index: Integer): T;
    function Count: Integer;
    property FirstNode: TNode<T> read GetFirstNode;
    property LastNode: TNode<T> read GetLastNode;
  end;

implementation

{ TNode<T> }

constructor TNode<T>.Create(AValue: T);
begin
  Value := AValue;
  Next := nil;
end;

{ TLinkedList<T> }

constructor TLinkedList<T>.Create;
begin
  FHead := nil;
  FTail := nil;
  FCount := 0;
end;

destructor TLinkedList<T>.Destroy;
begin
  Clear;
  inherited;
end;

procedure TLinkedList<T>.AddFirst(Value: T);
var
  NewNode: TNode<T>;
begin
  NewNode := TNode<T>.Create(Value);
  NewNode.Next := FHead;
  FHead := NewNode;
  if FCount = 0 then
    FTail := NewNode;
  Inc(FCount);
end;

procedure TLinkedList<T>.AddLast(Value: T);
var
  NewNode: TNode<T>;
begin
  NewNode := TNode<T>.Create(Value);
  if FCount = 0 then
    FHead := NewNode
  else
    FTail.Next := NewNode;
  FTail := NewNode;
  Inc(FCount);
end;

function TLinkedList<T>.RemoveFirst: T;
var
  Temp: TNode<T>;
begin
  if FCount = 0 then
    raise Exception.Create('List is empty');
  Temp := FHead;
  FHead := FHead.Next;
  if FCount = 1 then
    FTail := nil;
  Result := Temp.Value;
  Temp.Free;
  Dec(FCount);
end;

function TLinkedList<T>.RemoveLast: T;
var
  Current, Previous: TNode<T>;
begin
  if FCount = 0 then
    raise Exception.Create('List is empty');
  if FCount = 1 then
  begin
    Result := FHead.Value;
    FHead.Free;
    FHead := nil;
    FTail := nil;
  end
  else
  begin
    Current := FHead;
    while Current.Next <> FTail do
      Current := Current.Next;
    Result := FTail.Value;
    Current.Next := nil;
    FTail.Free;
    FTail := Current;
  end;
  Dec(FCount);
end;

function TLinkedList<T>.Remove(const Value: T): Boolean;
var
  Current, Previous: TNode<T>;
begin
  Result := False;
  if FCount = 0 then
    Exit;
  if FHead.Value = Value then
  begin
    RemoveFirst;
    Exit(True);
  end;
  Current := FHead.Next;
  Previous := FHead;
  while Current <> nil do
  begin
    if Current.Value = Value then
    begin
      Previous.Next := Current.Next;
      Current.Free;
      Dec(FCount);
      Exit(True);
    end;
    Previous := Current;
    Current := Current.Next;
  end;
end;

procedure TLinkedList<T>.Clear;
var
  Current, Temp: TNode<T>;
begin
  Current := FHead;
  while Current <> nil do
  begin
    Temp := Current;
    Current := Current.Next;
    Temp.Free;
  end;
  FHead := nil;
  FTail := nil;
  FCount := 0;
end;

function TLinkedList<T>.Contains(const Value: T): Boolean;
var
  Current: TNode<T>;
begin
  Current := FHead;
  while Current <> nil do
  begin
    if Current.Value = Value then
      Exit(True);
    Current := Current.Next;
  end;
  Result := False;
end;

procedure TLinkedList<T>.CopyTo(var ArrayOfT: array of T; Index: Integer);
var
  Current: TNode<T>;
  i: Integer;
begin
  if Index < 0 then
    raise Exception.Create('Index cannot be negative');
  if Index + FCount > Length(ArrayOfT) then
    raise Exception.Create('Array is too small to hold all elements');
  Current := FHead;
  i := Index;
  while Current <> nil do
  begin
    ArrayOfT[i] := Current.Value;
    Inc(i);
    Current := Current.Next;
  end;
end;

function TLinkedList<T>.ElementAt(Index: Integer): T;
var
  Current: TNode<T>;
  i: Integer;
begin
  if (Index < 0) or (Index >= FCount) then
    raise Exception.Create('Index out of bounds');
  Current := FHead;
  for i := 0 to Index - 1 do
    Current := Current.Next;
  Result := Current.Value;
end;

function TLinkedList<T>.First: T;
begin
  if FCount = 0 then
    raise Exception.Create('List is empty');
  Result := FHead.Value;
end;

function TLinkedList<T>.Last: T;
begin
  if FCount = 0 then
    raise Exception.Create('List is empty');
  Result := FTail.Value;
end;

function TLinkedList<T>.IndexOf(const Value: T): Integer;
var
  Current: TNode<T>;
  Index: Integer;
begin
  Current := FHead;
  Index := 0;
  while Current <> nil do
  begin
    if Current.Value = Value then
      Exit(Index);
    Inc(Index);
    Current := Current.Next;
  end;
  Result := -1;
end;

function TLinkedList<T>.RemoveAt(Index: Integer): T;
var
  Current, Previous: TNode<T>;
  i: Integer;
begin
  if (Index < 0) or (Index >= FCount) then
    raise Exception.Create('Index out of bounds');
  if Index = 0 then
    Exit(RemoveFirst);
  if Index = FCount - 1 then
    Exit(RemoveLast);
  Previous := FHead;
  for i := 0 to Index - 2 do
    Previous := Previous.Next;
  Current := Previous.Next;
  Previous.Next := Current.Next;
  Result := Current.Value;
  Current.Free;
  Dec(FCount);
end;

function TLinkedList<T>.Count: Integer;
begin
  Result := FCount;
end;

function TLinkedList<T>.GetFirstNode: TNode<T>;
begin
  Result := FHead;
end;

function TLinkedList<T>.GetLastNode: TNode<T>;
begin
  Result := FTail;
end;

end.
