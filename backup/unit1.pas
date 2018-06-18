unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls;

type
             TMyThread = class(TThread)
    private
      fStatusText : string;
      procedure ShowStatus;
      procedure movePlayerUp;
    protected
      procedure Execute; override;
    public
      Constructor Create(CreateSuspended : boolean);
    end;

  { TForm1 }

  TForm1 = class(TForm)
    IbigDot: TImage;
    IbigDot1: TImage;
    IbigDot2: TImage;
    IbigDot3: TImage;
    Ighost1: TImage;
    Ighost2: TImage;
    Ighost3: TImage;
    Ighost4: TImage;
    Iplayer: TImage;
    Llives: TLabel;
    Lscore: TLabel;
    Swall1: TShape;
    Swall10: TShape;
    Swall13: TShape;
    Swall14: TShape;
    Swall15: TShape;
    Swall16: TShape;
    Swall17: TShape;
    Swall18: TShape;
    Swall19: TShape;
    Swall2: TShape;
    Swall20: TShape;
    Swall21: TShape;
    Swall24: TShape;
    Swall25: TShape;
    Swall26: TShape;
    Swall27: TShape;
    Swall28: TShape;
    Swall29: TShape;
    Swall3: TShape;
    Swall30: TShape;
    Swall31: TShape;
    Swall32: TShape;
    Swall33: TShape;
    Swall34: TShape;
    Swall35: TShape;
    Swall36: TShape;
    Swall37: TShape;
    Swall38: TShape;
    Swall39: TShape;
    Swall4: TShape;
    Swall40: TShape;
    Swall41: TShape;
    Swall42: TShape;
    Swall43: TShape;
    Swall44: TShape;
    Swall45: TShape;
    Swall46: TShape;
    Swall47: TShape;
    Swall5: TShape;
    Swall7: TShape;
    Swall8: TShape;
    Swall9: TShape;
    TghostsNonHostile: TTimer;
    TmainTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LlivesClick(Sender: TObject);
    procedure LscoreClick(Sender: TObject);
    procedure Swall36ChangeBounds(Sender: TObject);
    procedure TghostsNonHostileTimer(Sender: TObject);
    procedure TmainTimerTimer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1; Iplayer : TImage;  direction : String;  I : Integer;  score: Integer; x : Integer; y : Integer;   MyForm : TImage;    MyThread : TMyThread; ghostsHostile : boolean;

implementation

{$R *.lfm}

                       constructor TMyThread.Create(CreateSuspended : boolean);
  begin
    inherited Create(CreateSuspended); // because this is black box in OOP and can reset inherited to the opposite again...
    FreeOnTerminate := True;  // better code...
  end;

  procedure TMyThread.ShowStatus;
  // this method is executed by the mainthread and can therefore access all GUI elements.
  begin
    Form1.Caption := fStatusText;
  end;

  procedure TMyThread.movePlayerUp;
  begin
   Iplayer.Top:=Iplayer.Top-10;
  end;

  procedure TMyThread.Execute;
  var
    newStatus : string;
  begin
    fStatusText := 'TMyThread Starting...';
    Synchronize(@Showstatus);
    fStatusText := 'TMyThread Running...';
    while (not Terminated) do
      begin
        If direction = 'U' then begin
                                      Synchronize(@movePlayerUp);
                                               end;

        if NewStatus <> fStatusText then
          begin
            fStatusText := newStatus;
            Synchronize(@Showstatus);
          end;
      end;
  end;

{ TForm1 }

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
begin
  Form1.Caption:=inttostr(Iplayer.Left);
  If key = 38 then begin
    direction := 'U';
  end;
  If key = 40 then begin
    direction := 'D';
  end;
   If key = 37 then begin
    direction := 'L';
  end;
   If key = 39 then begin
    direction := 'R';
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.LlivesClick(Sender: TObject);
begin

end;

function collidesWith(obj1 : TControl; obj2: TControl): boolean; begin
         if (obj1 <> obj2) then begin
                if ((obj1.Top >= obj2.Top) or (obj1.Top + obj1.Height >= obj2.Top)) then begin
                   if ((obj1.Top <= obj2.Top + obj2.Height) or (obj1.Top + obj1.Height <= obj2.Top + obj2.Height)) then begin
                      if ((obj1.Left >= obj2.Left) or (obj1.Left + obj1.Width >= obj2.Left)) then begin
                         if ((obj1.Left <= obj2.Left + obj2.Width) or (obj1.Left + obj1.Width <=obj2.Left + obj2.Width)) then begin
                            exit(true);
                         end;
                      end;
                   end;
                end;
             end;
         exit(false);
end;

procedure TForm1.LscoreClick(Sender: TObject); begin

  x := 30;
  while (x < Form1.Width - 30) do begin
    y := 29;
    while (y < Form1.Height - 60) do begin
      MyForm:=TImage.Create(Iplayer.Parent);
      MyForm.Name := 'Idot' + inttostr(x) + inttostr(y);
      MyForm.SetBounds(x, y, 5, 5);
      MyForm.Parent:=Iplayer.Parent;
      MyForm.Stretch:=true;
      MyForm.Proportional:=true;
      MyForm.Picture.LoadFromFile('Dot.png');
      y := y + 30;

      I := 0;
      while (I < Iplayer.Parent.ComponentCount) do begin
        if ((Iplayer.Parent.Components[I] is TShape) or ((Iplayer.Parent.Components[I] is TImage) and ((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('IbigDot')))) then begin
           if (collidesWith(MyForm, (Iplayer.Parent.Components[I] as TControl))) then begin
            MyForm.Parent:=nil;
           end;
        end;
        I := I + 1;
      end;
    end;
    x := x + 30;
  end;
end;

procedure TForm1.Swall36ChangeBounds(Sender: TObject);
begin

end;

procedure TForm1.TghostsNonHostileTimer(Sender: TObject); begin
  Ighost1.Picture.LoadFromFile('GhostRed.png');
             Ighost2.Picture.LoadFromFile('GhostPink.png');
             Ighost3.Picture.LoadFromFile('GhostOrange.png');
             Ighost4.Picture.LoadFromFile('GhostBlue.png');
     TghostsNonHostile.Enabled:=false;
     ghostsHostile := true;
end;

procedure addScore(points: Integer); begin
          score := score + points;

end;

procedure morphGhosts(hostile : boolean); begin

end;

procedure TForm1.TmainTimerTimer(Sender: TObject); begin
         If direction = 'U' then begin Iplayer.Top:=Iplayer.Top-3; Iplayer.Picture.LoadFromFile('Pacman270.png'); end;
         If direction = 'D' then begin Iplayer.Top:=Iplayer.Top+3; Iplayer.Picture.LoadFromFile('Pacman90.png'); end;
         If direction = 'L' then begin Iplayer.Left:=Iplayer.Left-3; Iplayer.Picture.LoadFromFile('Pacman180.png'); end;
         If direction = 'R' then begin Iplayer.Left:=Iplayer.Left+3;Iplayer.Picture.LoadFromFile('Pacman0.png');  end;

         if (direction <> '') then begin
         I := 0;
          while (I < Iplayer.Parent.ComponentCount) do begin
             if (Iplayer.Parent.Components[I] is TControl) then begin
                  if (collidesWith(Iplayer, (Iplayer.Parent.Components[I] as TControl))) then begin
                     if (Iplayer.Parent.Components[I] is TShape) then begin
                        If direction = 'U' then begin Iplayer.Top:=Iplayer.Top+3; end;
                        If direction = 'D' then begin Iplayer.Top:=Iplayer.Top-3; end;
                        If direction = 'L' then begin Iplayer.Left:=Iplayer.Left+3; end;
                        If direction = 'R' then begin Iplayer.Left:=Iplayer.Left-3 end;
                        direction := '';
                     end;

                     if (Iplayer.Parent.Components[I] is TImage) then begin
                        if (((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('Idot')) or ((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('IbigDot'))) then begin
                           addScore(10);
                           (Iplayer.Parent.Components[I] as TImage).Destroy;

                           if ((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('IbigDot')) then begin
                              ghostsHostile := false;
                              TghostsNonHostile.Enabled:=false;
                              Ighost1.Picture.LoadFromFile('GhostNonHostile.png');
                              Ighost2.Picture.LoadFromFile('GhostNonHostile.png');
                              Ighost3.Picture.LoadFromFile('GhostNonHostile.png');
                              Ighost4.Picture.LoadFromFile('GhostNonHostile.png');
                              TghostsNonHostile.Enabled:=true;
                           end;

                           I := I - 1;
                        end;

                     end;
                  end;
             end;

             I := I + 1;

          end;

          if (ghostsHostile = false) then begin

          end;

         end;

         Lscore.Caption := 'SCORE: ' + inttostr(score);
end;

         begin

             ghostsHostile := true;



           end.
end.

