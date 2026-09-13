package Processors.Game.Lobby.NijiaStar.Components
{
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Campaign.TMonster;
   import Logics.Campaign.TMonsters;
   import Logics.Characters.THero;
   import Logics.CrossServerWar.TChallengePlayer;
   import Logics.SLogicsCore;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NIJIASTAR;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIHeroHead extends TProcessorGame
   {
      
      protected var FMC_Head:MovieClip;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FMC_Select:MovieClip;
      
      protected var FMC_Pass:MovieClip;
      
      protected var MC_HuiTai:MovieClip;
      
      protected var FBM:Bitmap;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FSmallHeadSign:Boolean;
      
      protected var FOnClick:Function;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnPress:Function;
      
      protected var FOnRelease:Function;
      
      public function TUIHeroHead(param1:TUIComponent)
      {
         super(param1);
         this.FBM = new Bitmap();
      }
      
      protected function UIDispatch() : void
      {
         this.FMC_Head = this.FResource[CONST_NIJIASTAR.RESOURCES_Link_MC_Head];
         this.FTF_Level = this.FResource[CONST_NIJIASTAR.RESOURCES_Link_TF_Level];
         this.FTF_Name = this.FResource[CONST_NIJIASTAR.RESOURCES_Link_TF_Name];
         this.FMC_Select = this.FResource[CONST_NIJIASTAR.RESOURCES_Link_MC_Select];
         this.FMC_Pass = this.FResource[CONST_NIJIASTAR.RESOURCES_Link_MC_Pass];
         this.MC_HuiTai = this.FResource[CONST_NIJIASTAR.RESOURCES_Link_MC_HuiTai];
         if(this.FResource["MC_Taboo_Btn"])
         {
            MovieClip(this.FResource["MC_Taboo_Btn"]).visible = false;
         }
         if(this.FMC_Select != null)
         {
            this.FMC_Select.visible = false;
         }
         if(this.FMC_Pass != null)
         {
            this.FMC_Pass.visible = false;
         }
         this.Reset();
         this.FMC_Head.addChild(this.FBM);
         if(this.MC_HuiTai)
         {
            this.MC_HuiTai.mouseEnabled = false;
            this.MC_HuiTai.visible = false;
         }
      }
      
      protected function UIlocations() : void
      {
         this.FResource.addEventListener(MouseEvent.MOUSE_OUT,this.HeadOnOut,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_MOVE,this.HeadOnOver,false,0,true);
         this.FResource.addEventListener(MouseEvent.CLICK,this.HeadOnClick,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_DOWN,this.HeadOnDown,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_UP,this.HeadOnUp,false,0,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!this.Parent.Visible && !this.Parent.Parent.Visible)
         {
            return;
         }
         this.UpdateHeroHead();
         this.UpdateText();
      }
      
      protected function Reset() : void
      {
         if(this.FTF_Level != null)
         {
            this.FTF_Level.text = "";
         }
         if(this.FTF_Name != null)
         {
            this.FTF_Name.text = "";
         }
      }
      
      protected function UpdateHeroHead() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:THero = null;
         var _loc3_:TChallengePlayer = null;
         var _loc4_:uint = 0;
         var _loc5_:TMonster = null;
         var _loc6_:TMonsters = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TCoordinate = null;
         if(this.FContext == null)
         {
            this.FBM.bitmapData = null;
            this.Reset();
            return;
         }
         if(this.FContext is THero)
         {
            _loc2_ = this.FContext as THero;
            _loc4_ = _loc2_.SmallID;
         }
         else if(this.FContext is TChallengePlayer)
         {
            _loc3_ = this.FContext as TChallengePlayer;
            _loc2_ = _loc3_.TargetHeros.GetHeroByIndex(0);
            _loc4_ = _loc2_.SmallID;
         }
         else if(this.FContext is TMonsters)
         {
            _loc6_ = this.FContext as TMonsters;
            _loc8_ = uint(_loc6_.Count);
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc5_ = _loc6_.GetMonsterByIndex(_loc7_);
               if(_loc5_.IsChar)
               {
                  _loc4_ = _loc5_.MonsterHeadId;
                  break;
               }
               _loc7_++;
            }
         }
         else if(this.FContext is TMonster)
         {
            _loc5_ = this.FContext as TMonster;
            _loc4_ = _loc5_.MonsterHeadId;
         }
         _loc9_ = TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBM,CONST_MODULES.MODULE_NijiaStar,_loc4_);
         if(this.FSmallHeadSign)
         {
            this.FBM.scaleX = this.FBM.scaleY = 0.65;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:THero = null;
         var _loc2_:TChallengePlayer = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         if(this.FContext == null)
         {
            return;
         }
         if(this.FContext is THero)
         {
            _loc1_ = this.FContext as THero;
            _loc3_ = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.Level);
            _loc4_ = _loc1_.Name;
            _loc5_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc1_.Quality];
         }
         else if(this.FContext is TChallengePlayer)
         {
            _loc2_ = this.FContext as TChallengePlayer;
            _loc3_ = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc2_.TargetLevel);
            _loc4_ = _loc2_.TargetName;
            _loc5_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc2_.TargetQuality];
         }
         if(this.FTF_Level != null)
         {
            this.FTF_Level.text = _loc3_;
         }
         if(this.FTF_Name != null)
         {
            this.FTF_Name.text = _loc4_;
            if(_loc5_ != 0)
            {
               this.FTF_Name.textColor = _loc5_;
            }
         }
      }
      
      protected function HeadOnOver(param1:MouseEvent) : void
      {
         this.FResource.gotoAndStop(2);
         if(this.FOnOver != null)
         {
            this.FOnOver(this,this.FContext);
         }
      }
      
      protected function HeadOnOut(param1:MouseEvent) : void
      {
         this.FResource.gotoAndStop(1);
         if(this.FOnOut != null)
         {
            this.FOnOut(this,this.FContext);
         }
      }
      
      protected function HeadOnClick(param1:MouseEvent) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this,this.FContext);
         }
      }
      
      protected function HeadOnDown(param1:MouseEvent) : void
      {
         if(this.FOnPress != null)
         {
            this.FOnPress(this,this.FContext);
         }
      }
      
      protected function HeadOnUp(param1:MouseEvent) : void
      {
         if(this.FOnRelease != null)
         {
            this.FOnRelease(this,this.FContext);
         }
         param1.stopImmediatePropagation();
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function get OnOver() : Function
      {
         return this.FOnOver;
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get BM() : Bitmap
      {
         return this.FBM;
      }
      
      public function set BM(param1:Bitmap) : void
      {
         this.FBM = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function set SmallHeadSign(param1:Boolean) : void
      {
         this.FSmallHeadSign = param1;
      }
      
      public function set OnPress(param1:Function) : void
      {
         this.FOnPress = param1;
      }
      
      public function set OnRelease(param1:Function) : void
      {
         this.FOnRelease = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UIlocations();
      }
      
      public function Update() : void
      {
         var _loc1_:TChallengePlayer = null;
         if(this.FContext is TChallengePlayer)
         {
            _loc1_ = this.FContext as TChallengePlayer;
            if(_loc1_.IsDefeated)
            {
               this.FMC_Head.filters = [TGameUtil.GaryColorFilters];
               this.FMC_Pass.visible = true;
            }
            else
            {
               this.FMC_Head.filters = [];
               this.FMC_Pass.visible = false;
            }
         }
      }
      
      public function DefaultSelect() : void
      {
         this.HeadOnClick(null);
      }
      
      public function HideSelect() : void
      {
         this.FMC_Select.visible = false;
      }
      
      public function ShowSelect() : void
      {
         this.FMC_Select.visible = true;
      }
      
      public function set ShowMC_HuiTai(param1:Boolean) : void
      {
         if(this.MC_HuiTai)
         {
            this.MC_HuiTai.visible = param1;
         }
      }
      
      public function UpdateUI() : void
      {
         this.UpdateHeroHead();
         this.UpdateText();
      }
      
      public function UpdateBitmap() : void
      {
         this.UpdateHeroHead();
         this.UpdateText();
      }
   }
}

