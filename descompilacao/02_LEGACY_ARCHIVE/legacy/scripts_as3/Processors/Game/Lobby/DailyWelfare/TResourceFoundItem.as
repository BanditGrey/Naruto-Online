package Processors.Game.Lobby.DailyWelfare
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Resources.Constants.CONST_DAILYWELFARE;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TResourceFoundItem extends TUIComponent
   {
      
      public static const STATUS_CANGet:uint = 1;
      
      public static const STATUS_Geted:uint = 2;
      
      public static const STATUS_CANNot:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FResourceFoundIndex:uint;
      
      protected var FSilver:uint;
      
      protected var FExp:uint;
      
      protected var FIconIndex:uint;
      
      protected var FOnGetReward:Function;
      
      public function TResourceFoundItem(param1:TUIComponent)
      {
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_DAILYWELFARE.RESOURCE_ClassName_Item_Found) as MovieClip;
         addChild(this.FScene);
         this.FScene["MC_Icon"].mouseEnabled = false;
         this.FScene["MC_Status_Get"].mouseEnabled = false;
         this.FScene["TF_Times"].mouseEnabled = false;
         this.FScene["TF_Silver"].mouseEnabled = false;
         this.FScene["TF_Exp"].mouseEnabled = false;
         this.FScene["Btn_GetFree"].addEventListener(MouseEvent.CLICK,this.OnFreeClick);
         this.FScene["Btn_GetGold"].addEventListener(MouseEvent.CLICK,this.OnGoldClick);
      }
      
      protected function OnFreeClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.target) && !param1.target.buttonMode)
         {
            return;
         }
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this,this.FIconIndex,1);
         }
      }
      
      protected function OnGoldClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.target) && !param1.target.buttonMode)
         {
            return;
         }
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this,this.FIconIndex,0);
         }
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function get IconIndex() : uint
      {
         return this.FIconIndex;
      }
      
      public function get Btn_GetFree() : MovieClip
      {
         return this.FScene["Btn_GetFree"];
      }
      
      public function get Btn_GetGold() : MovieClip
      {
         return this.FScene["Btn_GetGold"];
      }
      
      public function InitData(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this.FResourceFoundIndex = param1;
         this.FSilver = param2;
         this.FExp = param3;
         this.FIconIndex = param4;
         this.FScene["MC_Icon"].gotoAndStop(param4);
      }
      
      public function SetData(param1:uint, param2:uint) : void
      {
         TGameUtil.setButtonMode(this.FScene["MC_BG"],param2 == STATUS_CANGet);
         TGameUtil.setButtonMode(this.FScene["Btn_GetFree"],param2 == STATUS_CANGet);
         TGameUtil.setButtonMode(this.FScene["Btn_GetGold"],param2 == STATUS_CANGet);
         if(param2 == STATUS_Geted)
         {
            this.FScene["MC_Status_Get"].visible = true;
            this.FScene["MC_Status_Get"].gotoAndPlay(1);
         }
         else
         {
            this.FScene["MC_Status_Get"].visible = false;
         }
         this.FScene["TF_Times"].text = String(param1);
         if(this.FResourceFoundIndex == 4)
         {
            this.FScene["TF_Silver"].text = STRING_COMMON.ITEMNAME_TeamBattlePoint + ":" + String(Math.max(param1,1) * this.FSilver);
         }
         else
         {
            this.FScene["TF_Silver"].text = STRING_COMMON.ITEMNAME_Coin + ":" + String(Math.max(param1,1) * this.FSilver);
         }
         this.FScene["TF_Exp"].text = STRING_COMMON.ITEMNAME_Exp + ":" + String(Math.max(param1,1) * this.FExp);
         if(param2 == STATUS_CANNot)
         {
            this.FScene.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.FScene.filters = [];
         }
      }
   }
}

