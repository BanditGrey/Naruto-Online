package Processors.Game.Lobby.Tower.Conponents
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TEnchantBattle;
   import Logics.SLogicsCore;
   import Logics.Tower.TTower;
   import Logics.Tower.TTowerData;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TOWER;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUITower extends TProcessorGame
   {
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Enter:TextField;
      
      protected var FTowerData:TTowerData;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FContextB:Object;
      
      protected var FEnterOnClick:Function;
      
      public function TUITower(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function UIDispatch() : void
      {
         if(this.FResource == null)
         {
            return;
         }
         this.FTF_Name = this.FResource["TF_Name"];
         this.FTF_Enter = this.FResource["TF_Enter"];
         TGameUtil.setButtonMode(this.FResource,true);
      }
      
      protected function UILocations() : void
      {
         this.FResource.addEventListener(MouseEvent.CLICK,this.ButtonEnterOnClick,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TEnchantBattle = null;
         var _loc3_:TTower = null;
         _loc1_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc2_ = this.FContext as TEnchantBattle;
         _loc3_ = this.FContextB as TTower;
         if(_loc2_ != null)
         {
            this.FTF_Name.text = _loc2_.Name;
            if(_loc2_.Level < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
            {
               this.FTF_Enter.text = TUtilityString.Format(STRING_TOWER.FORMAT_EnterLimit,_loc2_.Level);
            }
            else
            {
               this.FTF_Enter.text = TUtilityString.Format(STRING_TOWER.FORMAT_EnterLimitCopy,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc2_.Level));
            }
            if(_loc1_ < _loc2_.Level)
            {
               this.SetButtonState(false);
               return;
            }
            if(this.FTowerData.FreeExploreTimes != 0)
            {
               this.SetButtonState(true);
            }
            else
            {
               this.SetButtonState(_loc3_.TowerID != 0);
            }
         }
      }
      
      protected function SetButtonState(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FResource,param1);
         this.FResource.mouseEnabled = param1;
         this.FTF_Enter.filters = param1 ? [] : [TGameUtil.GaryColorFilters];
         this.FTF_Name.filters = param1 ? [] : [TGameUtil.GaryColorFilters];
      }
      
      protected function ButtonEnterOnClick(param1:MouseEvent) : void
      {
         if(this.FEnterOnClick != null)
         {
            this.FEnterOnClick(this,FTag);
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
      
      public function get EnterOnClick() : Function
      {
         return this.FEnterOnClick;
      }
      
      public function set EnterOnClick(param1:Function) : void
      {
         this.FEnterOnClick = param1;
      }
      
      public function get ContextB() : Object
      {
         return this.FContextB;
      }
      
      public function set ContextB(param1:Object) : void
      {
         this.FContextB = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function Update(param1:TTowerData) : void
      {
         this.FTowerData = param1;
         this.UpdateUI();
      }
   }
}

