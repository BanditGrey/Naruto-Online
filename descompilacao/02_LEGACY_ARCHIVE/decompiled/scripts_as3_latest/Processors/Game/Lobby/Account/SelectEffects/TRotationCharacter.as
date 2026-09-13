package Processors.Game.Lobby.Account.SelectEffects
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Resources.Constants.CONST_ACCOUNT;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class TRotationCharacter extends TUIComponent
   {
      
      protected static const CHARACTERCOUNT:uint = 7;
      
      protected static const RADIUS:uint = 372;
      
      protected static const MIN_ANGLE:uint = 90;
      
      protected static const MAX_ANGLE:uint = 270;
      
      protected static const ONE_GEAR:int = 1;
      
      protected static const TWO_GEAR:int = 2;
      
      protected static const THREE_GEAR:int = 3;
      
      protected static const FOUR_GEAR:int = 4;
      
      protected static const FIVE_GEAR:int = 5;
      
      protected static const SIX_GEAR:int = 6;
      
      protected static const SERVEN_GEAR:int = 7;
      
      protected static const FTargetPointIndex:int = 4;
      
      protected static const FHeadIcon:String = CONST_ACCOUNT.RESOURCE_MC_HeadIcon;
      
      protected static const FProfession:String = CONST_ACCOUNT.RESOURCE_MC_Profession;
      
      protected var FChatacterBox:Vector.<TCharacterBox>;
      
      protected var FRotationStatus:Boolean;
      
      protected var FRotationFlag:int;
      
      protected var FAntiRotation:Boolean;
      
      protected var FRotationPoints:Vector.<Point>;
      
      protected var FConstantPoint:Vector.<Point>;
      
      protected var FConstantIndex:Vector.<int>;
      
      protected var FCurrentCharacterBox:TCharacterBox;
      
      protected var FOnPlaySilhouette:Function;
      
      protected var FSelectCharacter:MovieClip;
      
      public function TRotationCharacter(param1:TUIComponent)
      {
         super(param1);
         this.FChatacterBox = new Vector.<TCharacterBox>(CHARACTERCOUNT);
         this.FRotationStatus = false;
         addEventListener(Event.ENTER_FRAME,this.OnRotation);
         this.FRotationFlag = 1;
         this.FConstantPoint = Vector.<Point>([new Point(1072,649),new Point(941,550),new Point(861,448),new Point(824,346),new Point(814,225),new Point(855,104),new Point(936,2),new Point(1007,-98)]);
         this.FConstantIndex = Vector.<int>([0,40,60,80,100,120,140,180]);
      }
      
      public function AngleToRadian(param1:Number) : Number
      {
         return param1 * (Math.PI / 180);
      }
      
      protected function OnRotation(param1:Event) : void
      {
         if(this.FRotationStatus)
         {
            this.RotationStart();
         }
      }
      
      protected function RotationStart() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         _loc2_ = int(CHARACTERCOUNT);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.ChangeProfession(this.FAntiRotation,this.FChatacterBox[_loc1_],_loc1_);
            this.GetRotationFlag(this.FChatacterBox[_loc1_].Subscript);
            if(this.FAntiRotation)
            {
               _loc3_ = this.FChatacterBox[_loc1_].Subscript - this.FRotationFlag;
            }
            else
            {
               _loc3_ = this.FChatacterBox[_loc1_].Subscript + this.FRotationFlag;
            }
            _loc4_ = CONST_ACCOUNT.RotationPoint[_loc3_];
            this.FChatacterBox[_loc1_].x = _loc4_.x;
            this.FChatacterBox[_loc1_].y = _loc4_.y;
            this.FChatacterBox[_loc1_].Subscript = _loc3_;
            _loc1_++;
         }
         if(this.FCurrentCharacterBox.x == this.FConstantPoint[FTargetPointIndex].x && this.FCurrentCharacterBox.y == this.FConstantPoint[FTargetPointIndex].y)
         {
            this.SetSelectCharacterMCFrame(this.FCurrentCharacterBox,3);
            this.FRotationStatus = false;
         }
      }
      
      public function GetRotationFlag(param1:int) : void
      {
         if(this.FAntiRotation)
         {
            if(param1 > this.FConstantIndex[6])
            {
               this.FRotationFlag = 4;
            }
            else if(param1 > this.FConstantIndex[5])
            {
               this.FRotationFlag = 2;
            }
            else if(param1 > this.FConstantIndex[4])
            {
               this.FRotationFlag = 2;
            }
            else if(param1 > this.FConstantIndex[3])
            {
               this.FRotationFlag = 2;
            }
            else if(param1 > this.FConstantIndex[2])
            {
               this.FRotationFlag = 2;
            }
            else if(param1 > this.FConstantIndex[1])
            {
               this.FRotationFlag = 2;
            }
            else if(param1 > this.FConstantIndex[0])
            {
               this.FRotationFlag = 4;
            }
         }
         else if(param1 < this.FConstantIndex[1])
         {
            this.FRotationFlag = 4;
         }
         else if(param1 < this.FConstantIndex[2])
         {
            this.FRotationFlag = 2;
         }
         else if(param1 < this.FConstantIndex[3])
         {
            this.FRotationFlag = 2;
         }
         else if(param1 < this.FConstantIndex[4])
         {
            this.FRotationFlag = 2;
         }
         else if(param1 < this.FConstantIndex[5])
         {
            this.FRotationFlag = 2;
         }
         else if(param1 < this.FConstantIndex[6])
         {
            this.FRotationFlag = 2;
         }
         else if(param1 < this.FConstantIndex[7])
         {
            this.FRotationFlag = 4;
         }
      }
      
      protected function SetCharacterFrame() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(CHARACTERCOUNT);
         _loc3_ = 1;
         _loc1_ = _loc2_;
         while(_loc1_ > 0)
         {
            this.FChatacterBox[_loc1_ - 1].SelectCharacterMC[FHeadIcon].gotoAndStop(_loc3_);
            this.FChatacterBox[_loc1_ - 1].ProfessionFrame = _loc3_;
            this.SetProfessionByFrame(this.FChatacterBox[_loc1_ - 1]);
            _loc3_++;
            _loc1_--;
         }
      }
      
      protected function SetCharacterByProfession(param1:TCharacterBox) : void
      {
         param1.SelectCharacterMC[FHeadIcon].gotoAndStop(param1.ProfessionFrame);
      }
      
      protected function SetProfessionByFrame(param1:TCharacterBox) : void
      {
         if(param1.ProfessionFrame == ONE_GEAR || param1.ProfessionFrame == TWO_GEAR)
         {
            param1.SelectCharacterMC[FProfession].gotoAndStop(ONE_GEAR);
         }
         if(param1.ProfessionFrame == THREE_GEAR || param1.ProfessionFrame == FOUR_GEAR)
         {
            param1.SelectCharacterMC[FProfession].gotoAndStop(TWO_GEAR);
         }
         if(param1.ProfessionFrame == FIVE_GEAR || param1.ProfessionFrame == SIX_GEAR)
         {
            param1.SelectCharacterMC[FProfession].gotoAndStop(THREE_GEAR);
         }
         if(param1.ProfessionFrame == SERVEN_GEAR)
         {
            param1.SelectCharacterMC[FProfession].gotoAndStop(ONE_GEAR);
         }
      }
      
      protected function ChangeProfession(param1:Boolean, param2:TCharacterBox, param3:int) : void
      {
         var _loc4_:int = 0;
         if(this.FAntiRotation)
         {
            if(param2.Subscript == this.FConstantIndex[0])
            {
               _loc4_ = param3 + 1;
               if(_loc4_ == 7)
               {
                  _loc4_ = 0;
               }
               param2.ProfessionFrame = this.FChatacterBox[_loc4_].ProfessionFrame;
               this.SetCharacterByProfession(param2);
               this.SetProfessionByFrame(param2);
               param2.Subscript = this.FConstantIndex[7];
            }
         }
         else if(param2.Subscript == this.FConstantIndex[7])
         {
            _loc4_ = param3 - 1;
            if(_loc4_ == -1)
            {
               _loc4_ = 6;
            }
            param2.ProfessionFrame = this.FChatacterBox[_loc4_].ProfessionFrame;
            this.SetCharacterByProfession(param2);
            this.SetProfessionByFrame(param2);
            param2.Subscript = this.FConstantIndex[0];
         }
      }
      
      protected function RotationOnClick(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurrentCharacterBox.Index;
         this.FCurrentCharacterBox = param1 as TCharacterBox;
         if(this.FCurrentCharacterBox.Subscript < this.FConstantIndex[4])
         {
            this.FAntiRotation = false;
         }
         else if(this.FCurrentCharacterBox.Subscript > this.FConstantIndex[4])
         {
            this.FAntiRotation = true;
         }
         else if(this.FCurrentCharacterBox.Subscript == this.FConstantIndex[4])
         {
            this.FRotationStatus = false;
            return;
         }
         this.SetSelectCharacterMCFrame(this.FCurrentCharacterBox,2);
         this.FRotationStatus = true;
         this.SetSelectCharacterMCFrame(this.FChatacterBox[_loc2_],1);
         this.PlaySilhouetteMC(false,this.FChatacterBox[_loc2_]);
         this.PlaySilhouetteMC(true,this.FCurrentCharacterBox);
      }
      
      protected function SetSelectCharacterMCFrame(param1:TCharacterBox, param2:int) : void
      {
         param1.SelectCharacterMC.gotoAndStop(param2);
         param1.SelectCharacterMC[FHeadIcon].gotoAndStop(param1.ProfessionFrame);
      }
      
      protected function PlaySilhouetteMC(param1:Boolean, param2:TCharacterBox) : void
      {
         if(this.FOnPlaySilhouette != null)
         {
            this.FOnPlaySilhouette(param2,param1);
         }
      }
      
      public function get SelectCharacter() : MovieClip
      {
         return this.FSelectCharacter;
      }
      
      public function set SelectCharacter(param1:MovieClip) : void
      {
         this.FSelectCharacter = param1;
      }
      
      public function get OnPlaySilhouette() : Function
      {
         return this.FOnPlaySilhouette;
      }
      
      public function set OnPlaySilhouette(param1:Function) : void
      {
         this.FOnPlaySilhouette = param1;
      }
      
      public function AddCharacterBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TCharacterBox = null;
         var _loc4_:Point = null;
         _loc2_ = int(CHARACTERCOUNT);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FConstantPoint[_loc1_];
            _loc3_ = new TCharacterBox(this);
            _loc3_.RotationOnClick = this.RotationOnClick;
            _loc3_.SelectCharacterMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACCOUNT.RESOURCE_MC_SelectCharacter) as MovieClip;
            _loc3_.Subscript = this.FConstantIndex[_loc1_];
            _loc3_.Index = _loc1_;
            _loc3_.x = _loc4_.x;
            _loc3_.y = _loc4_.y;
            this.FChatacterBox[_loc1_] = _loc3_;
            if(_loc1_ == FTargetPointIndex)
            {
               _loc3_.SelectCharacterMC.gotoAndStop(3);
               this.PlaySilhouetteMC(true,_loc3_);
               this.FCurrentCharacterBox = _loc3_;
            }
            _loc1_++;
         }
         this.SetCharacterFrame();
      }
      
      public function Release() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(CHARACTERCOUNT);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FChatacterBox[_loc1_].Release();
            this.FChatacterBox[_loc1_] = null;
            _loc1_++;
         }
         this.FChatacterBox.length = 0;
      }
   }
}

