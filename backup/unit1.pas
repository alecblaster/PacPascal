unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls;

type
     TGhost = class
  private
    img: TImage; direction: String; oldDirection: String;
  public
    constructor create(image: TImage); overload;
    procedure tick();
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
    Lwin: TLabel;
    Lscore: TLabel;
    LgameOver: TLabel;
    Sspacer: TShape;
    Sspacer1: TShape;
    Sspacer2: TShape;
    Sspacer3: TShape;
    Sspacer4: TShape;
    Sspacer5: TShape;
    Swall1: TShape;
    Swall10: TShape;
    Swall11: TShape;
    Swall12: TShape;
    Swall13: TShape;
    Swall14: TShape;
    Swall15: TShape;
    Swall16: TShape;
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
    Tanim: TTimer;
    TmainTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TanimTimer(Sender: TObject);
    procedure TghostsNonHostileTimer(Sender: TObject);
    procedure morphGhosts(hostile : boolean);
    procedure TmainTimerTimer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1; Iplayer : TImage;  direction : String; I : Integer;  score: Integer; x : Integer; y : Integer; wouldCollide : boolean;   MyForm : TImage; ghostsHostile : boolean; remDots : Integer; ghost1: TGhost; ghost2: TGhost; ghost3: TGhost; ghost4: TGhost; anim : String; frame : Integer; playerSpeed : Integer; ghostSpeed : Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
begin
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

procedure TForm1.TanimTimer(Sender: TObject); begin
  if (anim = 'DEATH') then begin
   if ((direction = 'U') and (frame = 0)) then begin frame := 1; end;
     case frame of
               0: Iplayer.Picture.LoadFromFile('Pacman270.png');
               1: Iplayer.Picture.LoadFromFile('Pacman270_death1.png');
               2: Iplayer.Picture.LoadFromFile('Pacman270_death2.png');
               3: Iplayer.Picture.LoadFromFile('Pacman270_death3.png');
               4: Iplayer.Picture.LoadFromFile('Pacman270_death4.png');
               5: Iplayer.Visible:=false;
          end;
          frame := frame +1;
          if (frame > 5) then begin frame := 0; anim:='GAME_OVER'; Tanim.Interval:=250; end;
  end else if (anim = 'GAME_OVER') then begin
      case frame of
               0: LgameOver.Visible:=true;
               1: LgameOver.Visible:=false;
          end;
          frame := frame +1;
          if (frame > 1) then begin frame := 0; end;
  end else if (anim = 'WIN') then begin
      case frame of
               0: Lwin.Font.Color:=TColor($00FFFF);
               1: Lwin.Font.Color:=TColor($FFFFFF);
          end;
          frame := frame +1;
          if (frame > 1) then begin frame := 0; end;
  end else if (anim = 'WALKING') then begin
            If (direction = 'U') then begin if (frame = 0) then begin Iplayer.Picture.LoadFromFile('Pacman270.png'); end else begin Iplayer.Picture.LoadFromFile('Pacman270_closed.png'); end; end;
            If (direction = 'D') then begin if (frame = 0) then begin Iplayer.Picture.LoadFromFile('Pacman90.png'); end else begin Iplayer.Picture.LoadFromFile('Pacman90_closed.png'); end; end;
            If (direction = 'L') then begin if (frame = 0) then begin Iplayer.Picture.LoadFromFile('Pacman180.png'); end else begin Iplayer.Picture.LoadFromFile('Pacman180_closed.png'); end; end;
            If (direction = 'R') then begin if (frame = 0) then begin Iplayer.Picture.LoadFromFile('Pacman0.png');  end else begin Iplayer.Picture.LoadFromFile('Pacman0_closed.png'); end; end;


          frame := frame +1;
          if (frame > 1) then begin frame := 0; end;
  end;
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

function wouldCollideWith(x: Integer; y: Integer; height: Integer; width: Integer; obj2: TControl): boolean; begin
                if ((y >= obj2.Top) or (y + height >= obj2.Top)) then begin
                   if ((y <= obj2.Top + obj2.Height) or (y + height <= obj2.Top + obj2.Height)) then begin
                      if ((x >= obj2.Left) or (x + width >= obj2.Left)) then begin
                         if ((x <= obj2.Left + obj2.Width) or (x + width <= obj2.Left + obj2.Width)) then begin
                            exit(true);
                         end;
                      end;
                   end;
                end;

         exit(false);
end;

procedure TForm1.FormCreate(Sender: TObject); begin
     ghost1 := TGhost.Create(Form1.Ighost1);
     ghost2 := TGhost.Create(Form1.Ighost2);
     ghost3 := TGhost.Create(Form1.Ighost3);
     ghost4 := TGhost.Create(Form1.Ighost4);
     x := 30;
  while (x < Form1.Width - 30) do begin
    y := 29;
    while (y < Form1.Height - 60) do begin

      I := 0; wouldCollide := false;
      while (I < Iplayer.Parent.ComponentCount) do begin
        if ((Iplayer.Parent.Components[I] is TShape) or ((Iplayer.Parent.Components[I] is TImage) and ((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('IbigDot')))) then begin
           if (wouldCollideWith(x, y, 5, 5, (Iplayer.Parent.Components[I] as TControl))) then begin
              wouldCollide := true;
              break;
           end;
        end;
        I := I + 1;
      end;

      if (wouldCollide = false) then begin
      MyForm:=TImage.Create(Iplayer.Parent);
      MyForm.Name := 'Idot' + inttostr(x) + inttostr(y);
      MyForm.SetBounds(x, y, 5, 5);
      MyForm.Parent:=Iplayer.Parent;
      MyForm.Stretch:=true;
      MyForm.Proportional:=true;
      MyForm.Picture.LoadFromFile('Dot.png');
      end;

      y := y + 30;
    end;
    x := x + 30;
  end;
end;

constructor TGhost.create(image: TImage); begin
          img := image;
          direction := 'U';
end;

procedure TGhost.tick(); begin
  if (img.Visible = true) then begin

   If direction = 'U' then begin img.Top:=img.Top-ghostSpeed; end;
   If direction = 'D' then begin img.Top:=img.Top+ghostSpeed; end;
   If direction = 'L' then begin img.Left:=img.Left-ghostSpeed; end;
   If direction = 'R' then begin img.Left:=img.Left+ghostSpeed; end;

   I := 0; remDots := 0;
          while (I < img.Parent.ComponentCount) do begin
             if (img.Parent.Components[I] is TControl) then begin
                  if (collidesWith(img, (img.Parent.Components[I] as TControl))) then begin
                     if ((img.Parent.Components[I] is TShape) and ((img.Parent.Components[I] as TControl).Name.StartsWith('Swall'))) then begin
                        If direction = 'U' then begin img.Top:=img.Top+ghostSpeed; end;
                        If direction = 'D' then begin img.Top:=img.Top-ghostSpeed; end;
                        If direction = 'L' then begin img.Left:=img.Left+ghostSpeed; end;
                        If direction = 'R' then begin img.Left:=img.Left-ghostSpeed; end;

                        oldDirection := direction;

                        case random(4) of
                        0 : direction := 'U';
                        1 : direction := 'D';
                        2 : direction := 'L';
                        3 : direction := 'R';
                        end;
                     end;
                  end;
             end;

             I := I + 1;
          end;
          end;
end;

procedure TForm1.TghostsNonHostileTimer(Sender: TObject); begin
  Ighost1.Picture.LoadFromFile('GhostRed.png');
     Ighost2.Picture.LoadFromFile('GhostPink.png');
  Ighost3.Picture.LoadFromFile('GhostOrange.png');
  Ighost4.Picture.LoadFromFile('GhostBlue.png');
  TghostsNonHostile.Enabled := false;
     ghostsHostile := true;
end;

procedure addScore(points: Integer); begin
          score := score + points;

end;

procedure TForm1.morphGhosts(hostile : boolean); begin
          ghostsHostile := hostile;

          if (hostile = false) then begin
            TghostsNonHostile.Enabled:=false;
            TghostsNonHostile.Enabled:=true;
          end;
end;

procedure TForm1.TmainTimerTimer(Sender: TObject); begin
         If direction = 'U' then begin Iplayer.Top:=Iplayer.Top-playerSpeed; end;
         If direction = 'D' then begin Iplayer.Top:=Iplayer.Top+playerSpeed; end;
         If direction = 'L' then begin Iplayer.Left:=Iplayer.Left-playerSpeed; end;
         If direction = 'R' then begin Iplayer.Left:=Iplayer.Left+playerSpeed; end;

         ghost1.tick(); ghost2.tick(); ghost3.tick(); ghost4.tick();

         I := 0;
          while (I < Iplayer.Parent.ComponentCount) do begin
             if (Iplayer.Parent.Components[I] is TControl) then begin
               if(((Iplayer.Parent.Components[I] as TControl).Name.StartsWith('Idot')) or ((Iplayer.Parent.Components[I] as TControl).Name.StartsWith('IbigDot'))) then begin
                                                 remDots := remDots + 1;
               end;
                  if (collidesWith(Iplayer, (Iplayer.Parent.Components[I] as TControl))) then begin
                     if ((Iplayer.Parent.Components[I] is TShape) and ((Iplayer.Parent.Components[I] as TControl).Name.StartsWith('Swall'))) then begin
                        If direction = 'U' then begin Iplayer.Top:=Iplayer.Top+playerSpeed; end;
                        If direction = 'D' then begin Iplayer.Top:=Iplayer.Top-playerSpeed; end;
                        If direction = 'L' then begin Iplayer.Left:=Iplayer.Left+playerSpeed; end;
                        If direction = 'R' then begin Iplayer.Left:=Iplayer.Left-playerSpeed end;
                        direction := '';
                     end else if (Iplayer.Parent.Components[I] is TImage) then begin
                        if (((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('Idot')) or ((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('IbigDot'))) then begin
                           addScore(10);

                           if ((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('IbigDot')) then begin
                              morphGhosts(false);

                              Ighost1.Picture.LoadFromFile('GhostNonHostile.png');
                              Ighost2.Picture.LoadFromFile('GhostNonHostile.png');
                              Ighost3.Picture.LoadFromFile('GhostNonHostile.png');
                              Ighost4.Picture.LoadFromFile('GhostNonHostile.png');

                           end;

                           (Iplayer.Parent.Components[I] as TImage).Destroy;
                           I := I - 1;
                        end else if (((Iplayer.Parent.Components[I] as TImage).Name.StartsWith('Ighost')) and ((Iplayer.Parent.Components[I] as TImage).Visible = true)) then begin
                           if (ghostsHostile) then begin
                           TmainTimer.Enabled:=false;
                           Tanim.Interval:=500;
                           anim := 'DEATH';

                           end else begin
                             addScore(200);
                             (Iplayer.Parent.Components[I] as TImage).Visible:=false;

                             I := I - 1;
                           end;

                        end;

                     end;
                  end;
             end;

             I := I + 1;

          end;

         Lscore.Caption := 'SCORE: ' + inttostr(score);
         if (remDots = 0) then begin
         Lwin.Visible:=true;
            TmainTimer.Enabled:=false;
            Tanim.Interval:=250;
                           anim := 'WIN';
         end;
end;

         begin
              anim := 'WALKING';
             ghostsHostile := true;
             randomize();
             playerSpeed:=5;
             ghostSpeed:=6;

           end.
end.

