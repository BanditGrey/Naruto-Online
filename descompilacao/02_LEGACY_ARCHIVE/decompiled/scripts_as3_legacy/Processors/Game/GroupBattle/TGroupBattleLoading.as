package Processors.Game.GroupBattle
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.SWF.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TGroupBattleLoading extends TProcessor
   {
      
      protected var FMax:int;
      
      protected var FCurrent:int;
      
      protected var FBattleBackgroud:Sprite;
      
      protected var FBattleScene:MovieClip;
      
      protected var FStartLoading:Boolean;
      
      protected var FCloseOk:Boolean;
      
      protected var FTimeCloseOk:uint;
      
      protected var FBattleTurn:uint;
      
      protected var FOnLoadingCompleted:Function;
      
      protected var FOnStartBattle:Function;
      
      public function TGroupBattleLoading(param1:TUIComponent)
      {
         super(param1);
         Visible = false;
         this.FStartLoading = false;
         this.InitWindow();
      }
      
      protected function InitWindow() : void
      {
         this.FBattleBackgroud = new Sprite();
         addChild(this.FBattleBackgroud);
         this.FBattleScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_GroupBattle_BattleLoad) as MovieClip;
         this.FBattleBackgroud.addChild(this.FBattleScene);
         this.FBattleScene.x = -650;
         this.FBattleBackgroud.graphics.beginFill(0);
         this.FBattleBackgroud.graphics.drawRect(-625,0,1250,650);
         this.FBattleBackgroud.graphics.endFill();
         this.FBattleScene.gotoAndStop(1);
         this.FBattleScene.addEventListener("closeOk",this.OnCloseOk);
         this.FBattleScene.addEventListener("openOk",this.OnOpenOk);
         this.FBattleScene["MC_Left"].gotoAndStop(1);
         this.FBattleScene["MC_Right"].gotoAndStop(1);
         this.FBattleScene["MC_Turn"].gotoAndStop(1);
         this.FBattleScene["MC_Turn"].visible = false;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.LogicsPerform_ProgressPercentage();
      }
      
      protected function LogicsPerform_ProgressPercentage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!this.FStartLoading)
         {
            return;
         }
         _loc1_ = int(SResourcesCore.PrimaryCount);
         if(_loc1_ == 0)
         {
            if(this.FMax != 0)
            {
               this.FMax = 0;
               this.FCurrent = 0;
            }
         }
         else
         {
            if(this.FCurrent == 0)
            {
            }
            if(_loc1_ > this.FMax)
            {
               this.FMax = _loc1_;
            }
            this.FCurrent = _loc1_;
         }
         if(this.FMax == 0)
         {
            if(this.FOnLoadingCompleted != null)
            {
               this.FOnLoadingCompleted(this);
            }
         }
      }
      
      protected function OnCloseOk(param1:Event) : void
      {
         this.FBattleScene["MC_Turn"].visible = true;
         this.FBattleScene["MC_Turn"].gotoAndPlay(1);
         this.FBattleScene["MC_Turn"]["MC_Turn"]["MC_Turn"].gotoAndStop(this.FBattleTurn);
         this.FCloseOk = true;
      }
      
      protected function OnOpenOk(param1:Event) : void
      {
         Visible = false;
         if(this.FOnStartBattle != null)
         {
            this.FOnStartBattle(this);
         }
      }
      
      public function get ResourcesLoading() : Boolean
      {
         return this.FCurrent != 0;
      }
      
      public function get OnLoadingCompleted() : Function
      {
         return this.FOnLoadingCompleted;
      }
      
      public function set OnLoadingCompleted(param1:Function) : void
      {
         this.FOnLoadingCompleted = param1;
      }
      
      public function get OnStartBattle() : Function
      {
         return this.FOnStartBattle;
      }
      
      public function set OnStartBattle(param1:Function) : void
      {
         this.FOnStartBattle = param1;
      }
      
      public function StartLoading(param1:uint) : void
      {
         this.FBattleTurn = param1;
         Visible = true;
         this.FStartLoading = true;
         this.FCloseOk = false;
         this.FBattleBackgroud.x = FUICore.StageWidth / 2;
         this.FBattleScene.gotoAndPlay("close");
      }
      
      public function EndLoading() : void
      {
         this.FStartLoading = false;
         if(this.FCloseOk == false)
         {
            clearTimeout(this.FTimeCloseOk);
            this.FTimeCloseOk = 0;
            this.FTimeCloseOk = setTimeout(this.EndLoading,500);
            return;
         }
         this.FTimeCloseOk = 0;
         this.FBattleScene.gotoAndPlay("open");
      }
   }
}

