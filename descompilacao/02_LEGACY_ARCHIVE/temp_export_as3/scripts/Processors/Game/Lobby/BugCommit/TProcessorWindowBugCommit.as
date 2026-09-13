package Processors.Game.Lobby.BugCommit
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Mail.TMail;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_BUGCOMMIT;
   import Resources.Strings.STRING_BUGCOMMIT;
   import Utilities.Timing.TUtilityTiming;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowBugCommit extends TProcessorLobbyWindow
   {
      
      public static const TIME_INTERVAL_UpdateCommitState:uint = 1 * 60 * 1000;
      
      public static const FORMAT_RefreshPrompt:String = STRING_BUGCOMMIT.FORMAT_RefreshPrompt;
      
      protected var FHintRefresh:THint;
      
      protected var FMC_BugCommit:Sprite;
      
      protected var FTF_BugText:TextField;
      
      protected var FBtn_Commit:MovieClip;
      
      protected var FBtn_Cancel:MovieClip;
      
      protected var FTimingRefreshReferenceTick:int;
      
      protected var FTimeIntervalRefreshCommit:uint;
      
      protected var FIsRefreshCommit:Boolean;
      
      protected var FIsBtnRefreshOver:Boolean;
      
      protected var FOnSendMail:Function;
      
      protected var FOnHitOver:Function;
      
      protected var FOnHitOut:Function;
      
      public function TProcessorWindowBugCommit(param1:TUIComponent)
      {
         super(param1);
         this.FHintRefresh = new THint();
         this.FTimeIntervalRefreshCommit = TIME_INTERVAL_UpdateCommitState;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BUGCOMMIT.RESOURCESID_Swf_BugCommit);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_BugCommit = TUtilityReflection.CreateDisplayObjectInstance(CONST_BUGCOMMIT.RESOURCE_ClassName_MC_BugCommit) as Sprite;
         addChild(this.FMC_BugCommit);
         this.FTF_BugText = this.FMC_BugCommit[CONST_BUGCOMMIT.RESOURCE_Link_TF_BugText];
         this.FBtn_Commit = this.FMC_BugCommit[CONST_BUGCOMMIT.RESOURCE_Link_Btn_Commit];
         this.FBtn_Cancel = this.FMC_BugCommit[CONST_BUGCOMMIT.RESOURCE_Link_Btn_Cancel];
         TGameUtil.setButtonMode(this.FBtn_Commit,true);
         TGameUtil.setButtonMode(this.FBtn_Cancel,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FTF_BugText.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput,false,0,true);
         super.ResourcesPerform_UILocations();
         this.FBtn_Commit.addEventListener(MouseEvent.CLICK,this.ButtonSendOnClick,false,0,true);
         this.FBtn_Cancel.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         _loc1_ = int(STimingCore.TickCount);
         this.LogicsPerform_RefreshCommit(_loc1_);
      }
      
      protected function LogicsPerform_RefreshCommit(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this.FIsRefreshCommit)
         {
            if(param1 - this.FTimingRefreshReferenceTick >= this.FTimeIntervalRefreshCommit)
            {
               this.FIsRefreshCommit = false;
               TGameUtil.setButtonMode(this.FBtn_Commit,true);
               this.BtnRefreshOnOut(null);
               this.FBtn_Commit.removeEventListener(MouseEvent.MOUSE_OVER,this.BtnRefreshOnOver);
               this.FBtn_Commit.removeEventListener(MouseEvent.MOUSE_OUT,this.BtnRefreshOnOut);
               if(this.FOnHitOut != null)
               {
                  this.FOnHitOut(this);
               }
            }
            if(this.FIsBtnRefreshOver)
            {
               _loc3_ = (this.FTimeIntervalRefreshCommit - (param1 - this.FTimingRefreshReferenceTick)) / 1000;
               _loc2_ = TUtilityString.Format(FORMAT_RefreshPrompt,TUtilityTiming.FormatDHMBySeconds(_loc3_));
               this.FHintRefresh.Caption = _loc2_;
               if(this.FOnHitOver != null)
               {
                  this.FOnHitOver(this,this.FHintRefresh);
               }
            }
            else if(this.FOnHitOut != null)
            {
               this.FOnHitOut(this);
            }
         }
      }
      
      protected function initialText() : void
      {
         this.FTF_BugText.text = "";
         stage.focus = this.FTF_BugText;
      }
      
      protected function BtnRefreshOnOver(param1:MouseEvent) : void
      {
         this.FIsBtnRefreshOver = true;
      }
      
      protected function BtnRefreshOnOut(param1:MouseEvent) : void
      {
         this.FIsBtnRefreshOver = false;
      }
      
      protected function onTextInput(param1:TextEvent) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(param1.currentTarget.text,"");
         _loc2_.writeMultiByte(param1.text,"");
         if(_loc2_.length > 400)
         {
            param1.preventDefault();
         }
      }
      
      protected function ButtonSendOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TMail = null;
         if(this.FIsRefreshCommit)
         {
            return;
         }
         _loc2_ = SLogicsCore.PoolMail.AcquireMail();
         _loc2_.Name = "#GM01";
         _loc2_.Subject = "GAME BUG";
         _loc2_.Detail = this.FTF_BugText.text;
         if(this.FOnSendMail != null)
         {
            this.FOnSendMail(this,_loc2_);
         }
         TGameUtil.setButtonMode(this.FBtn_Commit,false);
         this.FIsRefreshCommit = true;
         this.FTimingRefreshReferenceTick = STimingCore.TickCount;
         this.FBtn_Commit.addEventListener(MouseEvent.MOUSE_OVER,this.BtnRefreshOnOver,false,0,true);
         this.FBtn_Commit.addEventListener(MouseEvent.MOUSE_OUT,this.BtnRefreshOnOut,false,0,true);
         this.ButtonCloseOnClick(null);
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      public function get OnSendMail() : Function
      {
         return this.FOnSendMail;
      }
      
      public function set OnSendMail(param1:Function) : void
      {
         this.FOnSendMail = param1;
      }
      
      public function get OnHitOver() : Function
      {
         return this.FOnHitOver;
      }
      
      public function set OnHitOver(param1:Function) : void
      {
         this.FOnHitOver = param1;
      }
      
      public function get OnHitOut() : Function
      {
         return this.FOnHitOut;
      }
      
      public function set OnHitOut(param1:Function) : void
      {
         this.FOnHitOut = param1;
      }
      
      public function Reset() : void
      {
         this.initialText();
      }
   }
}

