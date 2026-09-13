package Processors.Game.GroupBattle
{
   import Foundation.Resources.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TGroupBattleWindowLost extends TProcessorLobbyWindow
   {
      
      protected var FScene:MovieClip;
      
      protected var FTF_Sure:TextField;
      
      protected var FLastTime:uint;
      
      protected var FCloseTime:uint;
      
      public function TGroupBattleWindowLost(param1:TUIComponent)
      {
         super(param1);
         this.InitWindow();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(Visible)
         {
            _loc1_ = this.FCloseTime - STimingCore.GetServerTick();
            this.FTF_Sure.text = TUtilityString.Format(STRING_GROUPBATTLE.STRING_SURE_BACK,_loc1_);
            if(_loc1_ <= 0)
            {
               ProcessorWindowClose();
            }
         }
      }
      
      protected function InitWindow() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_GroupBattle_Lost) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene["BTN_OK"],true);
         this.FScene["BTN_OK"].addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FTF_Sure = this.FScene["BTN_OK"]["TF_Sure"];
         this.FScene.x = (FUICore.StageWidth - this.FScene.width) / 2;
         this.FScene.y = (FUICore.StageHeight - this.FScene.height) / 2;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GROUPBATTLE_Lost) as TSystemLanguage;
         this.FScene["TF_Info"].text = _loc1_.Desc.split("%n").join("\n");
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GROUPBATTLE_OutTime) as TConfigValue;
         this.FLastTime = _loc2_.Value as uint;
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FScene != null && param1)
         {
            this.FScene["MC_Title"]["MC_Title"].gotoAndPlay(1);
            this.FCloseTime = STimingCore.GetServerTick() + this.FLastTime;
         }
      }
   }
}

