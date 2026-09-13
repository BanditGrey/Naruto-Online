package Processors.Game.Lobby.Magic.Window
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TMewBattle;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Magic.TMagicData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Magic.Components.TUIMoutain;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MAGIC;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_MAGIC;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowMoutainMap extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_Moutains:uint = 14;
      
      protected var FUIMoutains:Vector.<TUIMoutain>;
      
      protected var FUIMoutainsNew:Vector.<TUIMoutain>;
      
      protected var FBTN_Magic:MovieClip;
      
      protected var FMC_GoToOtherPanel:MovieClip;
      
      protected var FMC_OldPanel:MovieClip = null;
      
      protected var FMC_NewPanel:MovieClip = null;
      
      protected var FMC_GoToOtherPanelNew:MovieClip = null;
      
      protected var FMagicData:TMagicData;
      
      protected var FCurIndex:int = 1;
      
      protected var FEnterLevelOnClick:Function;
      
      protected var FOnEnterMagicClick:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      public function TProcessorWindowMoutainMap(param1:TUIComponent)
      {
         super(param1);
         this.FUIMoutains = new Vector.<TUIMoutain>(this.CAPACITY_Moutains);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MAGIC.RESOURCESID_Swf_Magic);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIMoutain = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_MAGIC.RESOURCE_ClassName_MC_MoutainMap) as Sprite;
         UIDispatch();
         this.FMC_OldPanel = FMainUI["MC_OldPanel"];
         this.FMC_NewPanel = FMainUI["MC_NewPanel"];
         _loc3_ = this.CAPACITY_Moutains / 2;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = new TUIMoutain(this);
            _loc1_.Resource = this.FMC_OldPanel[CONST_MAGIC.RESOURCE_Link_MC_Moutain + _loc2_] as MovieClip;
            _loc1_.Tag = _loc2_;
            _loc1_.ChallengeOnClick = this.ProcessorChallengeOnClick;
            _loc1_.Init();
            _loc1_.ThisPanelMove = this.ThisPanelMove;
            _loc1_.ThisPanelOut = this.ThisPanelOut;
            this.FUIMoutains[_loc2_] = _loc1_;
            _loc2_++;
         }
         _loc2_ = 7;
         while(_loc2_ < this.CAPACITY_Moutains)
         {
            _loc1_ = new TUIMoutain(this);
            _loc1_.Resource = this.FMC_NewPanel[CONST_MAGIC.RESOURCE_Link_MC_Moutain + (_loc2_ - 7)] as MovieClip;
            _loc1_.Tag = _loc2_;
            _loc1_.ChallengeOnClick = this.ProcessorChallengeOnClick;
            _loc1_.Init();
            _loc1_.ThisPanelMove = this.ThisPanelMove;
            _loc1_.ThisPanelOut = this.ThisPanelOut;
            this.FUIMoutains[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.FBTN_Magic = this.FMC_OldPanel["BTN_Magic"];
         TGameUtil.setButtonMode(this.FBTN_Magic,true);
         this.FMC_GoToOtherPanel = this.FMC_OldPanel["MC_GoToOtherPanel"];
         TGameUtil.setButtonMode(this.FMC_GoToOtherPanel,true);
         this.FMC_GoToOtherPanelNew = this.FMC_NewPanel["MC_GoToOtherPanel"];
         TGameUtil.setButtonMode(this.FMC_GoToOtherPanelNew,true);
         if(!SLogicsCore.Character.GetConfigValueById(91000010))
         {
            this.FMC_GoToOtherPanel.visible = false;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
         this.FBTN_Magic.addEventListener(MouseEvent.CLICK,this.EnterMagicOnClick,false,0,true);
         this.FMC_GoToOtherPanel.addEventListener(MouseEvent.CLICK,this.EnterGoToOtherPanelOnClick,false,0,true);
         this.FMC_GoToOtherPanelNew.addEventListener(MouseEvent.CLICK,this.EnterGoToOtherPanelOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.Mew_Battle_Tips) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      public function UpdateThisPanel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.CAPACITY_Moutains)
         {
            this.FUIMoutains[_loc1_].ContextCopy = this.FMagicData.MagicLevels.GetMagicLevelByIndex(_loc1_ * 3);
            this.FUIMoutains[_loc1_].Update();
            _loc1_++;
         }
      }
      
      protected function UpdataMCMoutains() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIMoutain = null;
         var _loc4_:TMewBattle = null;
         var _loc5_:uint = 0;
         _loc5_ = this.FMagicData.StageID;
         if(_loc5_ % 100 % 3 == 0)
         {
            _loc5_ = 100001 + _loc5_ % 100;
         }
         if(_loc5_ > 100042)
         {
            _loc5_ = 100042;
         }
         _loc4_ = this.FMagicData.MagicLevels.GetMagicLevelByIdentifier(_loc5_);
         _loc2_ = this.CAPACITY_Moutains;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIMoutains[_loc1_];
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function EnterMagicOnClick(param1:MouseEvent) : void
      {
         if(this.FOnEnterMagicClick != null)
         {
            this.FOnEnterMagicClick(this);
         }
      }
      
      protected function EnterGoToOtherPanelOnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_GoToOtherPanel:
               this.FCurIndex = 0;
               break;
            case this.FMC_GoToOtherPanelNew:
               this.FCurIndex = 1;
         }
         this.setVisible();
      }
      
      public function setVisible() : void
      {
         this.FMC_OldPanel.visible = false;
         this.FMC_NewPanel.visible = false;
         if(this.FCurIndex)
         {
            this.FMC_OldPanel.visible = true;
         }
         else
         {
            this.FMC_NewPanel.visible = true;
         }
      }
      
      protected function ProcessorChallengeOnClick(param1:Object, param2:int) : void
      {
         if(this.FEnterLevelOnClick != null)
         {
            this.FEnterLevelOnClick(this,param2);
         }
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      protected function ThisPanelMove(param1:TMewBattle, param2:int) : void
      {
         var _loc3_:THint = null;
         _loc3_ = new THint();
         if(param2 == 0)
         {
            _loc3_.Caption = TUtilityString.Format(STRING_MAGIC.Dec1,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(param1.NeedLevel));
         }
         else
         {
            _loc3_.Caption = TUtilityString.Format(STRING_MAGIC.Dec,STRING_MAGIC.STRING_Levels[param2 - 1],SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(param1.NeedLevel));
         }
         this.FUIHintOnOver(null,_loc3_);
      }
      
      protected function ThisPanelOut() : void
      {
         this.FUIHintOnOut(null);
      }
      
      public function get EnterLevelOnClick() : Function
      {
         return this.FEnterLevelOnClick;
      }
      
      public function set EnterLevelOnClick(param1:Function) : void
      {
         this.FEnterLevelOnClick = param1;
      }
      
      public function get OnEnterMagicClick() : Function
      {
         return this.FOnEnterMagicClick;
      }
      
      public function set OnEnterMagicClick(param1:Function) : void
      {
         this.FOnEnterMagicClick = param1;
      }
      
      public function UpdateCopy(param1:TMagicData) : void
      {
         this.FMagicData = param1;
      }
      
      public function Update(param1:TMagicData) : void
      {
         this.FMagicData = param1;
         this.UpdataMCMoutains();
      }
   }
}

