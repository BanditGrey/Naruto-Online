package Processors.Game.Lobby.TheWorldTree.LittlePanel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowDuoTasking_Congratulations extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:Sprite;
      
      protected var FMC_Movie:MovieClip;
      
      protected var FMC_CloseBtn:SimpleButton;
      
      protected var FTF_RewardDec:TextField;
      
      protected var FTF_MyRewardDec:TextField;
      
      protected var FTF_Dec:TextField;
      
      protected var FMC_MyWanOu:MovieClip;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var FBackFunction:Function;
      
      public function TProcessorWindowDuoTasking_Congratulations(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FLogicDate = SLogicsCore.TheWorldTreeLogicData;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("DuoTasking_Congratulations") as Sprite;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2 - 215;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2 - 190;
         this.FMC_Movie = this.FThisPanel["MC_Movie"];
         this.FMC_CloseBtn = this.FMC_Movie["MC_CloseBtn"];
         this.FTF_RewardDec = this.FMC_Movie["TF_RewardDec"]["TF_RewardDec"];
         this.FTF_RewardDec.mouseEnabled = false;
         this.FMC_MyWanOu = this.FMC_Movie["MC_MyWanOu"];
         this.FMC_MyWanOu.buttonMode = false;
         this.FMC_MyWanOu.mouseEnabled = false;
         this.FTF_MyRewardDec = this.FMC_MyWanOu["TF_NormalPrice"];
         this.FTF_MyRewardDec.mouseEnabled = false;
         this.FTF_Dec = this.FMC_MyWanOu["MC_MyWanOu"]["TF_Dec"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         this.FMC_CloseBtn.addEventListener(MouseEvent.CLICK,this.CloseClick);
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_Movie.gotoAndPlay(1);
         if(!this.FLogicDate.SureBtnIsClick)
         {
            this.FTF_RewardDec.text = this.FLogicDate.ShieldingVec[1].toString();
         }
         else
         {
            this.FTF_RewardDec.text = this.FLogicDate.SystemBid.toString();
         }
         _loc1_ = int(this.FLogicDate.ShieldingVec[1]);
         this.FTF_MyRewardDec.text = _loc1_.toString();
         _loc1_ = int(this.FLogicDate.ShieldingVec[0]);
         _loc1_++;
         this.FTF_Dec.text = _loc1_.toString();
         this.FLogicDate.SureBtnIsClick = false;
      }
      
      protected function CloseClick(param1:MouseEvent) : void
      {
         this.Visible = false;
         if(this.FBackFunction != null)
         {
            this.FBackFunction();
         }
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
   }
}

