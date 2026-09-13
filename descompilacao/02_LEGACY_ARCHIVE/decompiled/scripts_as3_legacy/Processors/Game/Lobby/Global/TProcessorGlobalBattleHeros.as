package Processors.Game.Lobby.Global
{
   import Components.ComboBox.TComboBox;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.GlobalBattle.TGlobalBattleUsers;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Global.Component.TUIGlobalBattleHeroModel;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class TProcessorGlobalBattleHeros extends TProcessorLobbyWindow
   {
      
      protected static const CAPACITY_Heros:uint = 6;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FHeroModules:Vector.<TUIGlobalBattleHeroModel>;
      
      protected var FComboBox:TComboBox;
      
      public function TProcessorGlobalBattleHeros(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:TUIGlobalBattleHeroModel = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("MC_GlobalBattleHeroModel") as Sprite;
         addChild(_loc1_);
         this.FComboBox = new TComboBox(this,_loc1_["MC_ComboBox"],null,10,this.SelectCallBack);
         this.FHeroModules = new Vector.<TUIGlobalBattleHeroModel>(CAPACITY_Heros);
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_Heros)
         {
            _loc3_ = new TUIGlobalBattleHeroModel(this);
            _loc3_.Resource = _loc1_["MC_Hero_" + _loc2_];
            this.FHeroModules[_loc2_] = _loc3_;
            _loc2_++;
         }
         this.FBTN_Close = _loc1_["BTN_Close"];
         _loc1_.x = (FUICore.StageWidth - _loc1_.width) / 2;
         _loc1_.y = (FUICore.StageHeight - _loc1_.height) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_FamilyList") as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function SelectCallBack(param1:Object, param2:int) : void
      {
      }
      
      public function UpdateHeroModule() : void
      {
      }
      
      public function UpdateComboBox(param1:TGlobalBattleUsers) : void
      {
         var _loc2_:Dictionary = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:String = null;
         _loc2_ = param1.HistoryUsersVec;
         for each(_loc4_ in ["1","2","3","4"])
         {
            _loc3_ = this.MakeComboItem(_loc4_);
            this.FComboBox.AddItem(_loc3_);
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIGlobalBattleHeroModel = null;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_Heros)
         {
            _loc2_ = this.FHeroModules[_loc1_];
            _loc2_.Update();
            _loc1_++;
         }
      }
   }
}

