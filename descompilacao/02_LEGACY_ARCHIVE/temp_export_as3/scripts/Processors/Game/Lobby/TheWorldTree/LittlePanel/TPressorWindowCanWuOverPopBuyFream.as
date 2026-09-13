package Processors.Game.Lobby.TheWorldTree.LittlePanel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPressorWindowCanWuOverPopBuyFream extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FMC_JieSaunBtn:MovieClip = null;
      
      protected var FTF_Text1:TextField;
      
      protected var FTF_Text2:TextField;
      
      protected var FCanOverBackFunction:Function;
      
      public function TPressorWindowCanWuOverPopBuyFream(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("TheWorldTree_Confirmation") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_JieSaunBtn = this.FThisPanel["MC_JieSaunBtn"];
         this.FTF_Text1 = this.FThisPanel["TF_Text1"];
         this.FTF_Text2 = this.FThisPanel["TF_Text2"];
         TGameUtil.setButtonMode(this.FMC_JieSaunBtn,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      public function UpdateView() : void
      {
         this.FTF_Text1.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str9).DescribeString,TGameUtil.fomatTime_NoDay(SLogicsCore.TheWorldTreeLogicData.CanWuAllTime));
         this.FTF_Text2.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str10).DescribeString,SLogicsCore.TheWorldTreeLogicData.OneTimesCanWuAllTime);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_JieSaunBtn.addEventListener(MouseEvent.CLICK,this.ClichHandle);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ClichHandle(param1:MouseEvent) : void
      {
         if(this.FCanOverBackFunction != null)
         {
            this.FCanOverBackFunction();
         }
      }
      
      public function set CanOverBackFunction(param1:Function) : void
      {
         this.FCanOverBackFunction = param1;
      }
   }
}

