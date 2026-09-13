package Processors.Game.Lobby.Magic.Components
{
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TMewBattle;
   import Logics.Magic.TMagicData;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUILevel extends TProcessorGame
   {
      
      protected var FMC_Select:Sprite;
      
      protected var FMC_Pass:Sprite;
      
      protected var FMC_Lock:Sprite;
      
      protected var FMC_Icon:Sprite;
      
      protected var FBmp:Bitmap;
      
      protected var FHeadIconID:uint;
      
      protected var FMagicData:TMagicData;
      
      protected var FLevelID:uint;
      
      protected var FMewBattle:TMewBattle;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FChallengeOnClick:Function;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      public function TUILevel(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function UIDispatch() : void
      {
         if(this.FResource == null)
         {
            return;
         }
         this.FBmp = new Bitmap();
         this.FMC_Select = this.FResource["MC_Select"];
         this.FMC_Lock = this.FResource["MC_Lock"];
         this.FMC_Pass = this.FResource["MC_Pass"];
         this.FMC_Icon = this.FResource["MC_Icon"];
         this.FMC_Icon.addChild(this.FBmp);
      }
      
      protected function UILocations() : void
      {
         this.FResource.addEventListener(MouseEvent.CLICK,this.ResourceOnClick,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_MOVE,this.ResourceOnMove,false,0,true);
         this.FResource.addEventListener(MouseEvent.MOUSE_OUT,this.ResourceOnOut,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TMewBattle = null;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         this.FMewBattle = this.FMagicData.MagicLevels.GetMagicLevelByIdentifier(this.FMagicData.StageID);
         _loc3_ = this.FMagicData.StageID;
         if(this.FContext is TMewBattle)
         {
            _loc1_ = this.FContext as TMewBattle;
            this.FHeadIconID = _loc1_.Image;
            this.FLevelID = _loc1_.Location;
            _loc2_ = false;
            if(_loc3_ == 0)
            {
               if(FTag == 0)
               {
                  this.SetMCVisible(_loc2_,_loc2_,!_loc2_);
               }
               else
               {
                  this.SetMCVisible(!_loc2_,_loc2_,_loc2_);
               }
            }
            else if(_loc3_ >= _loc1_.Identifier)
            {
               this.SetMCVisible(_loc2_,!_loc2_,_loc2_);
            }
            else if(_loc3_ + 1 == _loc1_.Identifier)
            {
               this.SetMCVisible(_loc2_,_loc2_,!_loc2_);
            }
            else
            {
               this.SetMCVisible(!_loc2_,_loc2_,_loc2_);
            }
         }
      }
      
      protected function SetMCVisible(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.FMC_Lock.visible = param1;
         this.FMC_Pass.visible = param2;
         this.FMC_Select.visible = param3;
      }
      
      protected function UpdateHeadIcon() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FHeadIconID != 0)
         {
            _loc1_ = TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBmp,CONST_MODULES.MODULE_Magic,this.FHeadIconID);
         }
         else
         {
            this.FBmp.bitmapData = null;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         this.UpdateHeadIcon();
         super.LogicsPerform();
      }
      
      protected function ResourceOnClick(param1:MouseEvent) : void
      {
         if(this.FMewBattle != null && this.FMewBattle.Location > this.FLevelID)
         {
            return;
         }
         if(this.FChallengeOnClick != null)
         {
            this.FChallengeOnClick(this,this.FContext);
         }
      }
      
      protected function ResourceOnMove(param1:MouseEvent) : void
      {
         if(this.FOnOver != null)
         {
            this.FOnOver(this,this.FContext);
         }
      }
      
      protected function ResourceOnOut(param1:MouseEvent) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this);
         }
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function get ChallengeOnClick() : Function
      {
         return this.FChallengeOnClick;
      }
      
      public function set ChallengeOnClick(param1:Function) : void
      {
         this.FChallengeOnClick = param1;
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
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function Update(param1:TMagicData) : void
      {
         this.FMagicData = param1;
         this.UpdateUI();
      }
   }
}

