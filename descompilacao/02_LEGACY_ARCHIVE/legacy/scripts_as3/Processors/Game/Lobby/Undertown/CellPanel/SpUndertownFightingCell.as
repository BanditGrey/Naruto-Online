package Processors.Game.Lobby.Undertown.CellPanel
{
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TDungeonsBattleConfig;
   import Logics.SLogicsCore;
   import Logics.Undertown.TUndertownLogicData;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class SpUndertownFightingCell extends Sprite
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FDungeonsBattleConfig:TDungeonsBattleConfig;
      
      protected var FCurLayer:int;
      
      protected var FTF_CustomsName:TextField;
      
      protected var FTF_CustomsDescribe:TextField;
      
      protected var FMC_BackIcon:MovieClip;
      
      protected var FUndertownLogicData:TUndertownLogicData;
      
      protected var FThisPanelBackFunction:Function;
      
      public function SpUndertownFightingCell()
      {
         super();
         this.LoadFla();
         this.FUndertownLogicData = SLogicsCore.UndertownLogicData;
      }
      
      protected function LoadFla() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_UndertownFightingCell") as MovieClip;
         this.addChild(this.FThisPanel);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MouseOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MouseDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MouseUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.OverOut);
         this.addEventListener(MouseEvent.CLICK,this.BackClcik);
         this.FThisPanel.mouseEnabled = false;
         this.FThisPanel.mouseChildren = false;
      }
      
      protected function BackClcik(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame == 4)
         {
            return;
         }
         if(this.FThisPanelBackFunction != null)
         {
            this.FThisPanelBackFunction(this.FDungeonsBattleConfig);
         }
      }
      
      protected function MouseOver(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame == 4)
         {
            return;
         }
         this.FThisPanel.gotoAndStop(2);
         this.FenNimeideA();
      }
      
      protected function MouseDown(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame == 4)
         {
            return;
         }
         this.FThisPanel.gotoAndStop(3);
         this.FenNimeideA();
      }
      
      protected function MouseUp(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame == 4)
         {
            return;
         }
         this.FThisPanel.gotoAndStop(1);
         this.FenNimeideA();
      }
      
      protected function OverOut(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame == 4)
         {
            return;
         }
         this.FThisPanel.gotoAndStop(1);
         this.FenNimeideA();
      }
      
      protected function FenNimeideA() : void
      {
         this.FMC_BackIcon = this.FThisPanel["MC_BackIcon"]["MC_BackIcon"];
         this.FTF_CustomsName = this.FThisPanel["MC_BackIcon"]["TF_CustomsName"];
         this.FTF_CustomsDescribe = this.FThisPanel["MC_BackIcon"]["TF_CustomsDescribe"];
         this.FMC_BackIcon.gotoAndStop(this.FCurLayer + 1);
         this.FTF_CustomsName.text = this.FDungeonsBattleConfig.CampaignName;
         var _loc1_:String = "";
         if(this.FDungeonsBattleConfig.OpenLevel > 1000)
         {
            _loc1_ = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_12).DescribeString;
         }
         else
         {
            _loc1_ = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_1).DescribeString;
         }
         this.FTF_CustomsDescribe.text = TUtilityString.Format(_loc1_,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FDungeonsBattleConfig.OpenLevel));
      }
      
      public function UpdateView() : void
      {
         this.FThisPanel.gotoAndStop(1);
         if(!this.buttonMode)
         {
            this.buttonMode = true;
         }
         if(this.FUndertownLogicData.CurCustomsData)
         {
            if(this.FUndertownLogicData.CurCustomsData.Identifier < this.FDungeonsBattleConfig.StageStartId || SLogicsCore.Character.GetMainLevel() < this.FDungeonsBattleConfig.OpenLevel)
            {
               this.FThisPanel.gotoAndStop(4);
               if(this.buttonMode)
               {
                  this.buttonMode = false;
               }
            }
         }
         this.FenNimeideA();
      }
      
      public function set CurLayer(param1:int) : void
      {
         this.FCurLayer = param1;
      }
      
      public function get CurLayer() : int
      {
         return this.FCurLayer;
      }
      
      public function set DungeonsBattleConfig(param1:TDungeonsBattleConfig) : void
      {
         this.FDungeonsBattleConfig = param1;
      }
      
      public function get DungeonsBattleConfig() : TDungeonsBattleConfig
      {
         return this.FDungeonsBattleConfig;
      }
      
      public function set ThisPanelBackFunction(param1:Function) : void
      {
         this.FThisPanelBackFunction = param1;
      }
   }
}

