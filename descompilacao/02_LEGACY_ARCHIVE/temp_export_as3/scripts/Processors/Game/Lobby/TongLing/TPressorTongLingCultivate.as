package Processors.Game.Lobby.TongLing
{
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.FourCell;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.TongLingAnimal.TongLingAttriteTip;
   import Rendering.Overlayers.TongLingAnimal.TongLingIntroTip;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   
   public class TPressorTongLingCultivate extends TProcessorLobbyWindow
   {
      
      protected static const TongLingFastStrone:uint = CONST_INVENTORY.CATEGORYSECOND_TongLingFastStrone;
      
      public static const numCell:int = 4;
      
      protected var RootMov:MovieClip;
      
      protected var VecFourCell:Vector.<FourCell>;
      
      protected var FExteShow:Function;
      
      protected var FSpeed:Function;
      
      protected var FOneKeySpeed:Function;
      
      protected var tipShop:TongLingAttriteTip;
      
      protected var per:TUIComponent;
      
      protected var FUcore:TUICore;
      
      protected var FIntroTip:TongLingIntroTip;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FSpeedHint:THint;
      
      protected var FOpenContion:int = 1;
      
      protected var VecOpens:Vector.<Object>;
      
      protected var VecPositions:Array;
      
      public function TPressorTongLingCultivate(param1:TUIComponent, param2:TUICore)
      {
         super(param1);
         this.per = param1;
         this.FUcore = param2;
         this.VecFourCell = new Vector.<FourCell>(numCell);
         this.VecPositions = new Array();
      }
      
      public function setRoot(param1:MovieClip, param2:Vector.<Object>, param3:int) : void
      {
         var _loc4_:FourCell = null;
         var _loc6_:Vector.<Object> = null;
         this.RootMov = param1;
         this.VecOpens = param2;
         var _loc5_:int = 0;
         while(_loc5_ < numCell)
         {
            _loc6_ = Vector.<Object>(this.VecOpens[_loc5_]);
            _loc4_ = new FourCell();
            _loc4_.setMovObj(this.RootMov["train" + _loc5_],_loc5_,this.per,_loc6_,param3);
            this.VecPositions.push({
               "X":MovieClip(this.RootMov["train" + _loc5_]).x,
               "Y":MovieClip(this.RootMov["train" + _loc5_]).y
            });
            _loc4_.move = this.move;
            _loc4_.over = this.Over;
            _loc4_.out = this.Out;
            _loc4_.Speed = this.Speed;
            _loc4_.OneKeySpeed = this.OneKeySpeed;
            _loc4_._Move = this._Move;
            _loc4_._Out = this._Out;
            _loc4_.setMsgObj(null);
            this.VecFourCell[_loc5_] = _loc4_;
            if(_loc5_ < numCell - 1)
            {
               this.VecFourCell[_loc5_].setSimpleBtn = false;
            }
            _loc5_++;
         }
         this.VecFourCell[0].setLevelScr = false;
         this.VecFourCell[0].setScr = false;
         this.VecFourCell[0].isOpenThis = 1;
         this.FIntroTip = new TongLingIntroTip(this.per);
         this.FIntroTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FIntroTip);
         this.tipShop = new TongLingAttriteTip(this.per);
         this.tipShop.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.tipShop);
         this.FSpeedHint = new THint();
         this.FOverlayerHint = new TOverlayerHint(this.per);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
      }
      
      public function _Move() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         var _loc5_:uint = 0;
         _loc3_ = SLogicsCore.Character.Appliances;
         _loc2_ = uint(_loc3_.Count);
         _loc5_ = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetInventoryByIndex(_loc1_);
            if(_loc4_.CategorySecond == TongLingFastStrone)
            {
               _loc5_ += _loc4_.Quantity;
            }
            _loc1_++;
         }
         if(_loc5_ <= 0)
         {
            this.FSpeedHint.Caption = STRING_TONGLING.TONGLING_13;
         }
         else
         {
            this.FSpeedHint.Caption = TUtilityString.Format(STRING_TONGLING.TONGLING_38,_loc5_);
         }
         this.FOverlayerHint.Context = this.FSpeedHint;
         this.FOverlayerHint.Render(this.FUcore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      public function _Out() : void
      {
         this.FOverlayerHint.Hide();
      }
      
      public function Over(param1:Object) : void
      {
         var _loc2_:Object = {
            "id":param1.id,
            "index":2,
            "level":param1.level,
            "Identifier0":param1.Identifier0,
            "Identifier1":param1.Identifier1
         };
         this.tipShop.Context = _loc2_;
         this.tipShop.Render(this.FUcore.MouseCoordinate);
         this.tipShop.Show();
      }
      
      public function Out() : void
      {
         this.tipShop.Hide();
      }
      
      public function move() : void
      {
         this.tipShop.Render(this.FUcore.MouseCoordinate);
      }
      
      public function Speed(param1:int, param2:int, param3:String, param4:uint, param5:uint) : void
      {
         this.FSpeed(param1,param2,param3,param4,param5);
      }
      
      public function OneKeySpeed(param1:int, param2:int, param3:String, param4:uint, param5:uint) : void
      {
         this.FOneKeySpeed(param1,param2,param3,param4,param5);
      }
      
      public function set SpeedFunction(param1:Function) : void
      {
         this.FSpeed = param1;
      }
      
      public function set OneKeySpeedFunction(param1:Function) : void
      {
         this.FOneKeySpeed = param1;
      }
      
      public function set ExteShow(param1:Function) : void
      {
         this.FExteShow = param1;
      }
      
      public function GetFourCellByIndex(param1:int) : FourCell
      {
         return this.VecFourCell[param1];
      }
      
      public function get getFourCellLength() : int
      {
         return this.VecFourCell.length;
      }
      
      public function ChangePostion() : void
      {
         if(this.FOpenContion)
         {
            MovieClip(this.RootMov["train0"]).x = Object(this.VecPositions[0]).X;
            MovieClip(this.RootMov["train0"]).y = Object(this.VecPositions[0]).Y;
            MovieClip(this.RootMov["train3"]).x = Object(this.VecPositions[1]).X;
            MovieClip(this.RootMov["train3"]).y = Object(this.VecPositions[1]).Y;
            MovieClip(this.RootMov["train1"]).x = Object(this.VecPositions[2]).X;
            MovieClip(this.RootMov["train1"]).y = Object(this.VecPositions[2]).Y;
            MovieClip(this.RootMov["train2"]).x = Object(this.VecPositions[3]).X;
            MovieClip(this.RootMov["train2"]).y = Object(this.VecPositions[3]).Y;
            this.FOpenContion = 0;
         }
      }
   }
}

