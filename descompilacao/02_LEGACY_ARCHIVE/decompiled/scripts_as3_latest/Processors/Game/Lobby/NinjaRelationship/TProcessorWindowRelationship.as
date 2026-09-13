package Processors.Game.Lobby.NinjaRelationship
{
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.NinjaRelation.TNinjaGroupBuff;
   import Logics.NinjaRelation.TNinjaGroupBuffs;
   import Logics.NinjaRelation.TNinjaRelationData;
   import Logics.NinjaRelation.TNinjaTeamBuff;
   import Logics.NinjaRelation.TNinjaTeamBuffs;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.NinjaRelationship.Component.TUINinjaGroup;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NinjaRelationship;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_NINJARELATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TProcessorWindowRelationship extends TProcessorWindowTemplate
   {
      
      protected static const MaskWidth:Number = 810;
      
      protected var FTF_RelationName:TextField;
      
      protected var FUITab:TUITab;
      
      protected var FTabX:Number;
      
      protected var FTabY:Number;
      
      protected var FProcessorWindowNinjaRelationDetail:TProcessorWindowNinjaRelationDetail;
      
      protected var FUINinjaGroups:Vector.<TUINinjaGroup>;
      
      protected var FMC_Attributes:Vector.<MovieClip>;
      
      protected var FTabIndex:int;
      
      protected var FNinjaRelationData:TNinjaRelationData;
      
      protected var FFilterNinjaGroupBuffs:TNinjaGroupBuffs;
      
      protected var FMC_ZheZhaoSiMiDa:MovieClip;
      
      protected var FMC_ZheZhaoSiMiDaBg:MovieClip;
      
      protected var FFilterRelationName:Array;
      
      protected var FFilterAttribute:Array;
      
      protected var FAddExpOnClick:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FToShowExchange:Function;
      
      public function TProcessorWindowRelationship(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FMC_Attributes = new Vector.<MovieClip>();
         this.FUINinjaGroups = new Vector.<TUINinjaGroup>();
         this.FNinjaRelationData = SLogicsCore.NinjaRelationData;
         this.FFilterNinjaGroupBuffs = new TNinjaGroupBuffs();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUINinjaGroup = null;
         var _loc5_:Sprite = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjaRelationship") as Sprite;
         UIDispatch();
         _loc5_ = new Sprite();
         this.FMC_ZheZhaoSiMiDa = FMainUI["MC_ZheZhaoSiMiDa"];
         this.FMC_ZheZhaoSiMiDaBg = this.FMC_ZheZhaoSiMiDa["MC_Bg"];
         this.FMC_ZheZhaoSiMiDaBg.alpha = 0.6;
         _loc2_ = CONST_NinjaRelationship.CAPACITY_TABS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["tabCon"]["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FTabX = FMainUI["tabCon"].x;
         this.FTabY = FMainUI["tabCon"].y;
         _loc2_ = CONST_NinjaRelationship.CAPACITY_ATTRIBUTES;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMC_Attributes[_loc1_] = FMainUI["MC_Attribute_" + _loc1_];
            _loc1_++;
         }
         this.FFilterAttribute = this.FMC_Attributes[0]["TF_Value"].filters;
         _loc2_ = CONST_NinjaRelationship.CAPACITY_GROUPS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Relation_" + _loc1_];
            _loc4_ = new TUINinjaGroup(this);
            _loc4_.Resource = _loc3_;
            _loc4_.OnLookupClick = this.ProcessorOnLookupClick;
            _loc4_.Init();
            this.FUINinjaGroups[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FTF_RelationName = FMainUI["TF_RelationName"];
         this.FFilterRelationName = this.FTF_RelationName.filters;
         this.FProcessorWindowNinjaRelationDetail = new TProcessorWindowNinjaRelationDetail(this);
         this.FProcessorWindowNinjaRelationDetail.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowNinjaRelationDetail.AddExpOnClick = this.ProcessorAddExpOnClick;
         this.FProcessorWindowNinjaRelationDetail.HintOnOver = this.FHintOnOver;
         this.FProcessorWindowNinjaRelationDetail.HintOnOut = this.FHintOnOut;
         this.FProcessorWindowNinjaRelationDetail.Load();
         this.FProcessorWindowNinjaRelationDetail.ToShowExchange = this.FToShowExchange;
      }
      
      public function ExchangeBackFun(param1:int, param2:uint, param3:uint) : void
      {
         this.FProcessorWindowNinjaRelationDetail.ExchangeBackFun(param1,param2,param3);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         UILocations();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_NinjaRelation) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         FMainUI["tabCon"].addEventListener(MouseEvent.MOUSE_DOWN,this.ProcessorOnMousedown);
         FUICore.UIStage.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnMouseup);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUINinjaGroup = null;
         if(!Visible)
         {
            return;
         }
         _loc2_ = CONST_NinjaRelationship.CAPACITY_GROUPS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUINinjaGroups[_loc1_];
            _loc3_.UpdataBitmap();
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TNinjaTeamBuff = null;
         var _loc4_:TNinjaTeamBuffs = null;
         _loc4_ = this.FNinjaRelationData.NinjaTeamBuffs;
         _loc2_ = CONST_NinjaRelationship.CAPACITY_TABS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetNinjaTeamBuffByIndex(_loc1_);
            if(_loc3_ != null)
            {
               this.FUITab.SetTabCaptionByIndex(_loc3_.TeamName,_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateNinjaGroupUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUINinjaGroup = null;
         var _loc4_:TNinjaGroupBuff = null;
         var _loc5_:Boolean = false;
         _loc2_ = CONST_NinjaRelationship.CAPACITY_GROUPS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUINinjaGroups[_loc1_];
            _loc3_.Context = null;
            _loc3_.Update();
            _loc1_++;
         }
         _loc4_ = this.FFilterNinjaGroupBuffs.GetNinjaGroupBuffByIndex(4);
         if(_loc4_.IsActivited && _loc4_.IsMistery)
         {
            _loc5_ = true;
         }
         else
         {
            _loc5_ = false;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUINinjaGroups[_loc1_];
            _loc4_ = this.FFilterNinjaGroupBuffs.GetNinjaGroupBuffByIndex(_loc1_);
            _loc4_.ShenMiIsActivited = _loc5_;
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateNinjaBuffs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:String = null;
         var _loc7_:TNinjaTeamBuff = null;
         _loc3_ = this.GetActivitedCount();
         this.FTF_RelationName.text = TUtilityString.Format(STRING_NINJARELATION.FORMAT_NINJARELATION_BUFF,this.FNinjaRelationData.NinjaTeamBuffs.GetNinjaTeamBuffByIndex(this.FTabIndex).TeamName,_loc3_);
         this.FTF_RelationName.filters = _loc3_ == 0 ? [TGameUtil.GaryColorFilters] : [];
         _loc7_ = this.FNinjaRelationData.NinjaTeamBuffs.GetNinjaTeamBuffByIndex(this.FTabIndex);
         if(_loc7_ == null)
         {
            return;
         }
         _loc2_ = _loc7_.BuffValue.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FMC_Attributes[_loc1_]["TF_Attribute"];
            _loc6_ = TUtilityString.Format(STRING_NINJARELATION.FORMAT_ATTRIBUTE_COUNT,_loc1_ + 1);
            _loc4_.text = _loc6_;
            _loc4_.filters = _loc1_ <= _loc3_ - 1 ? this.FFilterAttribute : [TGameUtil.GaryColorFilters];
            _loc5_ = this.FMC_Attributes[_loc1_]["TF_Value"];
            _loc5_.text = _loc7_.BuffValue[_loc1_];
            _loc5_.filters = _loc1_ <= _loc3_ - 1 ? this.FFilterAttribute : [TGameUtil.GaryColorFilters];
            _loc1_++;
         }
      }
      
      protected function GetActivitedCount() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TNinjaGroupBuff = null;
         _loc4_ = 0;
         _loc2_ = uint(this.FFilterNinjaGroupBuffs.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FFilterNinjaGroupBuffs.GetNinjaGroupBuffByIndex(_loc1_);
            if(_loc5_.IsActivited)
            {
               _loc4_++;
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      protected function FilterNinjaGroupBuffs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TNinjaGroupBuffs = null;
         var _loc4_:TNinjaGroupBuff = null;
         var _loc5_:TNinjaTeamBuffs = null;
         var _loc6_:TNinjaTeamBuff = null;
         var _loc7_:int = 0;
         _loc5_ = this.FNinjaRelationData.NinjaTeamBuffs;
         _loc6_ = _loc5_.GetNinjaTeamBuffByIndex(this.FTabIndex);
         _loc3_ = this.FNinjaRelationData.NinjaGroupBuffs;
         this.FFilterNinjaGroupBuffs.Clear();
         _loc2_ = uint(_loc3_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetNinjaGroupBuffByIndex(_loc1_);
            _loc7_ = _loc6_.TeamIDs.indexOf(_loc4_.TeamID);
            if(_loc7_ != -1)
            {
               this.FFilterNinjaGroupBuffs.Add(_loc4_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateUI() : void
      {
         this.FilterNinjaGroupBuffs();
         this.UpdateNinjaGroupUI();
         this.UpdateNinjaBuffs();
         this.UpdateMask();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.FilterNinjaGroupBuffs();
         this.UpdateNinjaGroupUI();
         this.UpdateNinjaBuffs();
         this.UpdateMask();
      }
      
      protected function ProcessorOnLookupClick(param1:Object, param2:Object) : void
      {
         this.FProcessorWindowNinjaRelationDetail.Visible = true;
         this.FProcessorWindowNinjaRelationDetail.Context = param2;
         this.FProcessorWindowNinjaRelationDetail.Update();
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         this.FProcessorWindowNinjaRelationDetail.Visible = false;
         this.FProcessorWindowNinjaRelationDetail.Reset();
      }
      
      protected function ProcessorAddExpOnClick(param1:Object, param2:Object, param3:uint, param4:uint, param5:uint) : void
      {
         if(this.FAddExpOnClick != null)
         {
            this.FAddExpOnClick(this,param2,param3,param4,param5);
         }
      }
      
      protected function ProcessorOnMousedown(param1:MouseEvent) : void
      {
         var _loc2_:Number = FMainUI["tabCon"].width - MaskWidth;
         var _loc3_:Number = this.FTabX - _loc2_;
         FMainUI["tabCon"].startDrag(false,new Rectangle(_loc3_,this.FTabY,_loc2_,0));
      }
      
      protected function ProcessorOnMouseup(param1:MouseEvent) : void
      {
         FMainUI["tabCon"].stopDrag();
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function set AddExpOnClick(param1:Function) : void
      {
         this.FAddExpOnClick = param1;
      }
      
      public function set ToShowExchange(param1:Function) : void
      {
         this.FToShowExchange = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function UpdateUIDetail() : void
      {
         this.UpdateUI();
         this.FProcessorWindowNinjaRelationDetail.Update();
      }
      
      protected function UpdateMask() : void
      {
         if(SLogicsCore.Character.MainHero.Level < 90 && this.FTabIndex == 4)
         {
            this.FMC_ZheZhaoSiMiDa.visible = true;
         }
         else
         {
            this.FMC_ZheZhaoSiMiDa.visible = false;
         }
      }
      
      public function TabChangeByIndex(param1:int) : void
      {
         this.FTabIndex = param1;
         this.FUITab.TabIndex = param1;
      }
   }
}

