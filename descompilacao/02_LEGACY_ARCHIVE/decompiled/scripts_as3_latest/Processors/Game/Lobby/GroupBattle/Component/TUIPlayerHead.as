package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityCartisian;
   import Logics.GroupBattle.TRoomDetailInfo;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIPlayerHead extends TProcessorUIResourceTemplate
   {
      
      protected var DISTANCE_WIDTH:uint = 89;
      
      protected var DISTANCE_HEIGHT:uint = 81;
      
      protected var CAPACITY_HEROHEADS:uint = 3;
      
      protected var FMC_Master:Sprite;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_FightPower:TextField;
      
      protected var FMC_HeroHead:MovieClip;
      
      protected var FIsPress:Boolean;
      
      protected var FUIHeroHead:TUIHeroHead;
      
      protected var FRoomDetailInfo:TRoomDetailInfo;
      
      protected var FOnPress:Function;
      
      protected var FOnRelease:Function;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      public function TUIPlayerHead(param1:TUIComponent)
      {
         super(param1);
         this.FIsPress = false;
         this.FRoomDetailInfo = SLogicsCore.GroupBattleData.RoomDetailInfo;
      }
      
      override protected function UIDispatch() : void
      {
         this.FMC_Master = FResource["MC_Master"];
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Level = FResource["TF_Level"];
         this.FTF_FightPower = FResource["TF_FightPower"];
         this.FMC_HeroHead = FResource["MC_HeroHead"];
         this.FTF_Level.selectable = false;
         this.FTF_Name.selectable = false;
         this.FUIHeroHead = new TUIHeroHead(this);
         this.FUIHeroHead.Resource = this.FMC_HeroHead;
         this.FUIHeroHead.OnOver = this.ProcessorOnOver;
         this.FUIHeroHead.OnOut = this.ProcessorOnOut;
         this.FUIHeroHead.OnPress = this.ProcessorOnPress;
         this.FUIHeroHead.OnRelease = this.ProcessorOnRelease;
         this.FUIHeroHead.Init();
      }
      
      override protected function UILocations() : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,this.MouseOnUp,false,0,true);
      }
      
      protected function CheckMousePosition() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TCoordinate = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc1_ = mouseX;
         _loc2_ = mouseY;
         _loc3_ = this.GetPosPoint(FResource);
         _loc4_ = _loc3_.X;
         _loc5_ = _loc3_.Y;
         if(_loc1_ >= _loc4_ && _loc1_ <= _loc4_ + this.DISTANCE_WIDTH && _loc2_ >= _loc5_ && _loc2_ <= _loc5_ + this.DISTANCE_HEIGHT)
         {
            return FTag;
         }
         return -1;
      }
      
      public function GetPosPoint(param1:MovieClip) : TCoordinate
      {
         var _loc2_:TCoordinate = null;
         return TUtilityCartisian.GetScreenCoordinateByDisplayObject(param1);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TRoomPlayer = null;
         this.Reset();
         if(FContext == null)
         {
            this.FUIHeroHead.Context = null;
            return;
         }
         _loc1_ = FContext as TRoomPlayer;
         this.FTF_Name.text = _loc1_.PlayerName;
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(_loc1_.PlayerLevel);
         this.FTF_FightPower.text = _loc1_.FightPower.ToString();
         this.FUIHeroHead.Context = _loc1_.Heros.GetHeroByIdentifier(_loc1_.PlayerModelID);
         this.FMC_Master.visible = this.FRoomDetailInfo.HostIndex == FTag;
      }
      
      protected function ProcessorOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOver != null)
         {
            this.FOnOver(this,FContext);
         }
      }
      
      protected function ProcessorOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,FContext);
         }
      }
      
      protected function ProcessorOnPress(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            _loc3_ = -1;
         }
         else
         {
            _loc3_ = FTag;
         }
         if(this.FOnPress != null)
         {
            this.FOnPress(this,param2,_loc3_);
         }
         this.FIsPress = true;
      }
      
      protected function ProcessorOnRelease(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = this.CheckMousePosition();
         if(this.FOnRelease != null)
         {
            this.FOnRelease(this,_loc3_);
         }
      }
      
      protected function MouseOnUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!FParent.Visible || !this.FIsPress)
         {
            return;
         }
         this.FIsPress = false;
         if(this.FOnRelease != null)
         {
            this.FOnRelease(this,-1);
         }
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function set OnPress(param1:Function) : void
      {
         this.FOnPress = param1;
      }
      
      public function set OnRelease(param1:Function) : void
      {
         this.FOnRelease = param1;
      }
      
      override public function Reset() : void
      {
         this.FTF_FightPower.text = "";
         this.FTF_Level.text = "";
         this.FTF_Name.text = "";
         this.FMC_Master.visible = false;
      }
      
      public function UpdateHeroHead() : void
      {
      }
   }
}

