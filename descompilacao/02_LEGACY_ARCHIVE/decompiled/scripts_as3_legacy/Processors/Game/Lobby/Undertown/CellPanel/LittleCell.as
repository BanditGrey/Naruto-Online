package Processors.Game.Lobby.Undertown.CellPanel
{
   import Logics.DatebaseVO.VO.TDungeonsBattle;
   import Logics.SLogicsCore;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class LittleCell
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FThisIndex:int;
      
      protected var FMC_ChallengeedLabel:MovieClip;
      
      protected var FMC_CurCanChallengeIcon:MovieClip;
      
      protected var FTF_CustomsName:TextField;
      
      protected var FCurData:TDungeonsBattle;
      
      public function LittleCell(param1:MovieClip, param2:int)
      {
         super();
         this.FThisPanel = param1;
         this.FThisIndex = param2;
         this.UIDispatch();
      }
      
      public function set CurData(param1:TDungeonsBattle) : void
      {
         this.FCurData = param1;
      }
      
      protected function UIDispatch() : void
      {
         this.FMC_ChallengeedLabel = this.FThisPanel["MC_ChallengeedLabel"];
         this.FMC_ChallengeedLabel.mouseEnabled = false;
         this.FMC_CurCanChallengeIcon = this.FThisPanel["MC_CurCanChallengeIcon"];
         this.FMC_CurCanChallengeIcon.mouseEnabled = false;
         this.FTF_CustomsName = this.FThisPanel["TF_CustomsName"];
         this.FTF_CustomsName.mouseEnabled = false;
      }
      
      public function UpdateView() : void
      {
         var _loc1_:TDungeonsBattle = null;
         this.FTF_CustomsName.text = this.FCurData.Name;
         _loc1_ = SLogicsCore.UndertownLogicData.CurCustomsData;
         if(!_loc1_)
         {
            this.FMC_ChallengeedLabel.visible = true;
            this.FMC_CurCanChallengeIcon.visible = false;
            this.FThisPanel.gotoAndStop(1);
         }
         else
         {
            if(_loc1_.Identifier > this.FCurData.Identifier)
            {
               this.FMC_ChallengeedLabel.visible = true;
            }
            else
            {
               this.FMC_ChallengeedLabel.visible = false;
            }
            if(_loc1_.Identifier == this.FCurData.Identifier)
            {
               this.FMC_CurCanChallengeIcon.visible = true;
            }
            else
            {
               this.FMC_CurCanChallengeIcon.visible = false;
            }
            if(_loc1_.Identifier < this.FCurData.Identifier)
            {
               this.FThisPanel.gotoAndStop(2);
            }
            else
            {
               this.FThisPanel.gotoAndStop(1);
            }
         }
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
   }
}

