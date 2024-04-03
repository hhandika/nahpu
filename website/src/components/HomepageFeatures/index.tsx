import clsx from "clsx";
import Heading from "@theme/Heading";
import styles from "./styles.module.css";

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<"svg">>;
  description: JSX.Element;
};

const FeatureList: FeatureItem[] = [
  {
    title: "Built to handle complex fieldwork",
    Svg: require("@site/static/img/complexFieldwork.svg").default,
    description: (
      <>
        NAHPU seamlessly integrates specimen data, including localities,
        collecting effort, tissue sample information, and photographs.
      </>
    ),
  },
  {
    title: "Designed for modern collecting",
    Svg: require("@site/static/img/responsibleCollecting.svg").default,
    description: (
      <>
        NAHPU boosts efficiency of specimen data collection, streamlines data
        management, and provides real-time summaries for data monitoring.
      </>
    ),
  },
  {
    title: "Accessible for everyone",
    Svg: require("@site/static/img/forEveryone.svg").default,
    description: (
      <>
        NAHPU is a free, open-source app that works on various devices. We are
        creating multilingual instructions to ensure NAHPU is universally
        accessible and easy to use.
      </>
    ),
  },
];

function Feature({ title, Svg, description }: FeatureItem) {
  return (
    <div className={clsx("col col--4")}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
