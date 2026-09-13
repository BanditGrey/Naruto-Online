package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.GroupBattle.TGroupBattleLevel;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIBattleSelect extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Level:TextField;
      
      protected var FTF_BattleName:TextField;
      
      protected var FMC_Select:Sprite;
      
      protected var FFilter:Array;
      
      protected var FBattleUIOnClick:Function;
      
      protected var FShowSelectBox:Boolean;
      
      public function TUIBattleSelect(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Level = FResource["TF_Level"];
         this.FTF_BattleName = FResource["TF_BattleName"];
         this.FMC_Select = FResource["MC_Select"];
         this.FMC_Select.visible = false;
         FResource.mouseChildren = false;
         FResource.buttonMode = true;
         this.FFilter = FResource.filters;
      }
      
      override protected function UILocations() : void
      {
         FResource.addEventListener(MouseEvent.CLICK,this.MCBattleUIOnClick,false,0,true);
         super.UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TGroupBattleLevel = null;
         var _loc2_:String = null;
         Reset();
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TGroupBattleLevel;
         if(_loc1_.IsOpenLevel)
         {
            _loc2_ = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.OpenLevel);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_Unlocked,SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.OpenLevel));
         }
         this.FTF_Level.text = _loc2_;
         this.FTF_BattleName.text = _loc1_.LevelName;
         FResource.filters = _loc1_.IsOpenLevel ? this.FFilter : [TGameUtil.GaryColorFilters];
      }
      
      protected function MCBattleUIOnClick(param1:MouseEvent) : void
      {
         if(this.FBattleUIOnClick != null)
         {
            this.FBattleUIOnClick(this,FContext);
         }
      }
      
      public function set BattleUIOnClick(param1:Function) : void
      {
         this.FBattleUIOnClick = param1;
      }
      
      public function get ShowSelectBox() : Boolean
      {
         return this.FShowSelectBox;
      }
      
      public function set ShowSelectBox(param1:Boolean) : void
      {
         this.FShowSelectBox = param1;
         this.FMC_Select.visible = this.FShowSelectBox;
      }
   }
}

